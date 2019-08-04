import { Config } from '@jest/types';
export default function withEnzyme(preset: Config.ProjectConfig): {
    setupFilesAfterEnv: string[];
    snapshotSerializers: string[];
    testEnvironmentOptions: {
        enzymeAdapter: string;
    };
    testEnvironment: string;
    automock: boolean;
    browser: boolean;
    cache: boolean;
    cacheDirectory: string;
    clearMocks: boolean;
    coveragePathIgnorePatterns: string[];
    cwd: string;
    dependencyExtractor?: string | undefined;
    detectLeaks: boolean;
    detectOpenHandles: boolean;
    displayName?: string | {
        name: string;
        color: "black" | "red" | "green" | "yellow" | "blue" | "magenta" | "cyan" | "white" | "gray" | "grey" | "blackBright" | "redBright" | "greenBright" | "yellowBright" | "blueBright" | "magentaBright" | "cyanBright" | "whiteBright" | "bgBlack" | "bgRed" | "bgGreen" | "bgYellow" | "bgBlue" | "bgMagenta" | "bgCyan" | "bgWhite" | "bgBlackBright" | "bgRedBright" | "bgGreenBright" | "bgYellowBright" | "bgBlueBright" | "bgMagentaBright" | "bgCyanBright" | "bgWhiteBright";
    } | undefined;
    errorOnDeprecated: boolean;
    extraGlobals: ("undefined" | "Array" | "ArrayBuffer" | "Boolean" | "Buffer" | "DataView" | "Date" | "Error" | "EvalError" | "Float32Array" | "Float64Array" | "Function" | "GLOBAL" | "Infinity" | "Int16Array" | "Int32Array" | "Int8Array" | "Intl" | "JSON" | "Map" | "Math" | "NaN" | "Number" | "Object" | "Promise" | "RangeError" | "ReferenceError" | "RegExp" | "Set" | "String" | "Symbol" | "SyntaxError" | "TypeError" | "URIError" | "Uint16Array" | "Uint32Array" | "Uint8Array" | "Uint8ClampedArray" | "WeakMap" | "WeakSet" | "clearImmediate" | "clearInterval" | "clearTimeout" | "console" | "decodeURI" | "decodeURIComponent" | "encodeURI" | "encodeURIComponent" | "escape" | "eval" | "global" | "isFinite" | "isNaN" | "parseFloat" | "parseInt" | "process" | "root" | "setImmediate" | "setInterval" | "setTimeout" | "queueMicrotask" | "unescape" | "gc" | "v8debug")[];
    filter: string | null | undefined;
    forceCoverageMatch: string[];
    globalSetup: string | null | undefined;
    globalTeardown: string | null | undefined;
    globals: Record<string, any>;
    haste: Config.HasteConfig;
    moduleDirectories: string[];
    moduleFileExtensions: string[];
    moduleLoader: string;
    moduleNameMapper: [string, string][];
    modulePathIgnorePatterns: string[];
    modulePaths: string[];
    name: string;
    prettierPath: string;
    resetMocks: boolean;
    resetModules: boolean;
    resolver: string | null | undefined;
    restoreMocks: boolean;
    rootDir: string;
    roots: string[];
    runner: string;
    setupFiles: string[];
    skipFilter: boolean;
    skipNodeResolution: boolean;
    snapshotResolver: string | null | undefined;
    testMatch: string[];
    testLocationInResults: boolean;
    testPathIgnorePatterns: string[];
    testRegex: string[];
    testRunner: string;
    testURL: string;
    timers: "real" | "fake";
    transform: [string, string, Record<string, unknown>][];
    transformIgnorePatterns: string[];
    watchPathIgnorePatterns: string[];
    unmockedModulePathPatterns: string[] | null | undefined;
} | undefined;
export { withEnzyme };
//# sourceMappingURL=index.d.ts.map