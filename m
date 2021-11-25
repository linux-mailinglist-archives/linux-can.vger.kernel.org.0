Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B220B45DB38
	for <lists+linux-can@lfdr.de>; Thu, 25 Nov 2021 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352127AbhKYNkz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Nov 2021 08:40:55 -0500
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:17733
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352407AbhKYNiz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 25 Nov 2021 08:38:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr15eheohv+cjX9QyrI55lU6Rzjn1JvMYDpit6dk+3ojlJGM30qsj6AoJR35re46/MUXOVjKPzsefXxIAuSi7M7Gpm1gbSy5Me9qmWl162T7knXrlg9sGaMkPXlUsYX3Zd9ZqllNVa6QzoJpSZOMiu0d1BWnPYIrUPxmh6IA9imnyi+rNXMqvkPnfTLefXxXQvn4mTTlLKqXbLCpfR0RIdHkbf2ghSDGLNQR5/nJqYgsn20X/zQj2PCQQWuUQcvFHTe01UDnoFsmu6tPk+oWsxFnXoe5f/Z4k3ciQ84KoWFxd/g0pyv0vruv0syqGisaFk4YgEXRtXjTXgsfo4Vrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgSvON1oB6HI2NEmOuDpL3+yzC0RZE6FJ8Z893yCis4=;
 b=JCFJuEh5XEF60m9yuL/SrKUm175uhdUTNkW+/FdzRgf6FDa1uYMtaGjp+HLdTXjOcVxqNOqv0mikorF08EJYRWC+IUJGmj2hug1k9PbPfYaJ74bnMoXaEMfMasO/DCGJND9dGrP39XCKdnQ22CHa+xgFot+KjqXRNKLUnJecbRXoUKPdDBvsVD3aj7wXrjlk8gqD1zous8j+T4o4hwIg3wPV2IBe2eggm+xvioqfVaz2xoM8+ojJQ7tw9IgaTZU7GBfc4cSKBxhdvhgLgLodByPF0JNTPmxioZzOvjNNo3/2ykPl0IKqAK5dnXEdB0Nleb24deDwMb3Eqok6B5QLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgSvON1oB6HI2NEmOuDpL3+yzC0RZE6FJ8Z893yCis4=;
 b=mNSQdUWnzP0tZPfsBL0s16EsYwVUcCi15SUrbs2Rx2WKTmD+bWlGkwE9FpFrrPg4vFx86jKBM0T9xZydS7N0KJKaiatTIJKlh8/I7DggS59Ualt0PCXPMoNY3fgfFkmIC005CJTxNN8/ux3DK2lepx+lKWEDQ+ie2e+H+ymCQMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2293.eurprd02.prod.outlook.com (2603:10a6:4:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 13:35:42 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 13:35:42 +0000
Message-ID: <24781209-928b-dea4-de0b-b103dac8de82@axentia.se>
Date:   Thu, 25 Nov 2021 14:35:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v3 1/4] dt-bindings: mux: Increase the number of
 arguments in mux-controls
Content-Language: sv-SE
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20211123081222.27979-1-a-govindraju@ti.com>
 <20211123081222.27979-2-a-govindraju@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211123081222.27979-2-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0032.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::33) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0032.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Thu, 25 Nov 2021 13:35:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2d107ef-bd8a-4749-1b27-08d9b01879ba
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2293:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB22932DAE2AD68DC966A6B752BC629@DB6PR0201MB2293.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9UmTF90W4d4CbeJnkHEiCCBXqMpsTVQQ7v2FYjhuNJkOHz8Oun0omQQ0+BieXzDI/8Jn3DrhyvHJCRzbYMheXGyJn3jF+qqPDT5vdMg1ue63/55cvERfJuwo5vq0CcbONeZpP1ZIxOl5enKpxfEUYLK4K0CqKkQK/V2Xg3NjdOriSjtD2mCGxsZQF5FEbTO93GEub5wCGfjz2vafd43sVLb7svn0/cDNgvWzTCNg5GiLaJy7sUYCq1wFOyv1CPTWz1Kydj79wr3bf2pJDRKxqJbqnMyOWUcNJRcljSJ79zhTfEXbQV5FcegdbUEvL3TLewGEfnBQXLWAugEgwb3uqz3507S9uefL9uf9leWYfhjy3DBTBjk0Dq/NN2U/S5xFaBIqJFuMT2YK+SKzjgxqojjbV+oiTtHYOAAdczTeLc/oY7yZdptJJJR7OYi52eAeAAmyKZEcGiWGot4+MFGqLGc1ucspGq8zcG6ET36kobPDUlEifLMU8aJslf6nYhrNZttNa0qPqy5RQ+A5OrO0W42iBCyrv1Z1vjRyU1HGQwdvESovBk9tcscbjPuFtRsesHMBNUhsXsV3nYG1CGVE21M4Ttv5ElcMe3HqNLNNriW3lOnCBFDv4sBlVOm8w57lIPLhMw7StZ50nIHchxZWCF6/3CeXweCnoHxEdQDt9dtiJ9Cmd3v5PA0yJw4LMHfxbhMkzH9FO0U5zPZTX9/BBJJ9AaL+FAZVeqjIzDfiEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39830400003)(366004)(8676002)(8936002)(186003)(7416002)(86362001)(508600001)(4326008)(36756003)(38100700002)(4001150100001)(2616005)(66946007)(66476007)(66556008)(6916009)(956004)(2906002)(31686004)(16576012)(6486002)(5660300002)(316002)(83380400001)(26005)(31696002)(53546011)(36916002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzQ3eHZYcUp0YjAyc0JjbGtFZEFNUHZ4YXBjOVozeGVFTUdkVU9UYzNnRExp?=
 =?utf-8?B?b1JYWFNzY1NLVkhxSWxoanBmMDlaQUdPR1dlVXNyS2NHR3RCSFlyRUNPcUt5?=
 =?utf-8?B?SGFnTVNzUGttSFVxNTRGeXVEVWNNUUl4Q0lTSGcyYzEralU4KzR1Rk1Uc0FL?=
 =?utf-8?B?ZFNxanlrak9neExvWmFEa1pQWVd0L2RZNnpnUU9iMW1zWGppWGFBeEN3S0N1?=
 =?utf-8?B?UUQ2U0xEdGdtTWJZT3dtTVZjdWZqQlFwNUVSL241ODZMb3JaZGZScmsrakhG?=
 =?utf-8?B?NTc2RlgxRkhtOEFVeG9lZ04wa2tTK3RrejhZV2xBd1g0UDdJLzdxYnNBYUEv?=
 =?utf-8?B?SHhEZ3pvWWpZQWZoeCtyK09VV0x2Tkx2aXRzdlZBQnpZRFZKYjVsbHVFcFFO?=
 =?utf-8?B?aEUyN1lSWmpaOTk5Q1RPeVhseUM3aXkvR2M0OHFScVYveGpqMlJWQWNodW53?=
 =?utf-8?B?VUJibHZiTU9sYUEvdjBSYldFRGF4eGtLbFpscU91dFpSR2tuTWsyQ1J1ekRM?=
 =?utf-8?B?QmNXSGhxb1F5MUttRlFtaHFTS1RpYVF2Mk4xd3lLR29HV1NIYVh4Y1FCQnpm?=
 =?utf-8?B?Z2dCaW1MUUgzNEtpUFgvT0xHZm0vR2NOSmhyZldUcytpcHFsU0YyeGxacVNP?=
 =?utf-8?B?U053Q0hYcW1UUFlKdzVQQkpQTHpPMyt2QlhVNjVGbWVXTDg0L3lTa3QxaE5p?=
 =?utf-8?B?SzRhTnRNWU9VSlkyRVBoSFZzK0NTL2trRGxOZHNieHVlNDFyN3grNEt4U1Ew?=
 =?utf-8?B?WUJOUXN6TkZqUEZNcW84UTliMXU3S01qU3pLMFJ4TDlkRWwrOXVZeDN5ZWhv?=
 =?utf-8?B?Q3pEaEt4cFFZcG8vREEwYnYrSnFNS050eitheS9FVmptbWxDTHl5UHdRRnFU?=
 =?utf-8?B?MkRZZFFDZTJOb004eWVmR3RlalVaSjhqaVpIUlppTW1TNUVBaUs5QnRJZ0Jn?=
 =?utf-8?B?c243VFJEaDNyS1QwZkhOU1RLb0NnM3haVUZaM2Q3VVlYUmRvbi9ISFNCcUly?=
 =?utf-8?B?NHIvYVA0bjY5ZzJEcGxTRjZGRWRrNUhBdGdZUGRmT2d4MFRmR2pEdCs4UDVW?=
 =?utf-8?B?ODZwRG5oeGx5WFlYYVRlb2RnalEwcE1FUXRpZFNucGEwYkRSdjRuVWF4aXlU?=
 =?utf-8?B?MDZlNzYxS2ppVjJyRi9PSXN2ZGZTUkg3QTRablJuWmlQQlpJcjhCY2tvNkVp?=
 =?utf-8?B?Qzk5aGJpbmNqTVpINktUMS85b3E0aHg4WTFGK0tSc0VVMnZuNm1GeWhtcWR0?=
 =?utf-8?B?M3Q0U05QbGpxMlgvTDkrZldUODdFTlJ4YzYvRFhKRkhVc1U3UVRIeEJwVWJv?=
 =?utf-8?B?eHpYUmNSUnQvWlJLRGVBV2J4cTJpNmVVV0sxeU5LOHFrZU1sWWtEaWQxUFhG?=
 =?utf-8?B?VUwzejFEdzFNZjVpTHBnQWJKTXdRRUlUYzJlSTVvOFdMdWN1aTBPZlQzcVNM?=
 =?utf-8?B?dkNKTWpvQnpPWmIwTWhONGtNcXVOZG1jNE80VjEyUUhOM3hIRjk0K1lzanB4?=
 =?utf-8?B?R1pscXUwdVNtTC8vMTI3RVJ0d3F4R0l6MzNsNW41UjFRZENJdk9JV3E0ZEdw?=
 =?utf-8?B?bVFyZGRiem5IdkNBVWdDN0ljamNDbE1sRW55V1BzQjFQMDlHU3FWbEhiQ1JW?=
 =?utf-8?B?R0tldGlDVXBrWTBvQ2xhZmswYVlvZDM3bk8vSVU0WmtadDgreTRHRVFtRGZz?=
 =?utf-8?B?TkxvM1pIS21HVEJaVys2cFRnZVVmdVNHTEJMdk5NdytLN0ozVmhJL1liKy9X?=
 =?utf-8?B?TnNMT3BHMTZHNUlyZkhsejZOb1FKaGNmbFRYSU1tM1BkQVNzY3M2MzNJS1h1?=
 =?utf-8?B?VGcvbUU1SkpNN3hnTlFycEkxcUhyMDF3Y3lVYmhKWUJzekdpREZKRjA5a29D?=
 =?utf-8?B?M1pGY3hNaS9PUUIrTVdTeTA4UFlPZlozb25jK0tpQ3pRMGYvcTNoV3Y4bW16?=
 =?utf-8?B?aDJ2a2hRM1lKOVFhQ1p6eHJGNGp6Q3Jwa2pCT2cyWHRKQlZJZ09QYlk1WGZw?=
 =?utf-8?B?aG1uMk5wQVM4UklzZ0oyN3g4Z21NaTF0NHZYUkdvZDdQZzVpbWpMbk8wUjdB?=
 =?utf-8?B?Q3dYZzl0eUFLMU9BRGx0TzBnbW9MTXJIZjhYbHplNldGOWVIUHlZT0ZrZ3R0?=
 =?utf-8?Q?AsJc=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d107ef-bd8a-4749-1b27-08d9b01879ba
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 13:35:42.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iQk5Ohwp0mkpS/Z0W0HJmB4LqRl6rRocFPkFH+nhL1B+fjVM+tGaWWQ9mlnauAp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2293
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!

You need to have some description on how #mux-control-cells now work.
The previous description is in mux-consumer.yaml and an update there
is needed.

However, I have realized that the adg792a binding uses #mux-control-cells
to indicate if it should expose its three muxes with one mux-control
and operate the muxes in parallel, or if it should be expose three
independent mux-controls. So, the approach in this series to always
have the #mux-control-cells property fixed at <2> when indicating a
state will not work for that binding. And I see no fix for that binding
without adding a new property.

So, I would like a different approach. Since I dislike how mux-controls
-after this series- is not (always) specifying a mux-control like the name
says, but instead optionally a specific state, the new property I would
like to add is #mux-state-cells such that it would always be one more
than #mux-control-cells.

	mux: mux-controller {
		compatible = "gpio-mux";
		#mux-control-cells = <0>;
		#mux-state-cells = <1>;

		mux-gpios = <...>;
	};

	can-phy {
		compatible = "ti,tcan1043";
		...
		mux-states = <&mux 1>;
	};

That solves the naming issue, the unused argument for mux-conrtrollers
that previously had #mux-control-cells = <0>, and the binding for adg792a
need no longer be inconsistent.

Or, how should this be solved? I'm sure there are other options...

Cheers,
Peter

On 2021-11-23 09:12, Aswath Govindraju wrote:
> Increase the allowed number of arguments in mux-controls to add support for
> passing information regarding the state of the mux to be set, for a given
> device.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/mux/gpio-mux.yaml       | 2 +-
>  Documentation/devicetree/bindings/mux/mux-controller.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> index 0a7c8d64981a..c810b7df39de 100644
> --- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> +++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> @@ -26,7 +26,7 @@ properties:
>        List of gpios used to control the multiplexer, least significant bit first.
>  
>    '#mux-control-cells':
> -    const: 0
> +    enum: [ 0, 1, 2 ]
>  
>    idle-state:
>      default: -1
> diff --git a/Documentation/devicetree/bindings/mux/mux-controller.yaml b/Documentation/devicetree/bindings/mux/mux-controller.yaml
> index 736a84c3b6a5..0b4b067a97bf 100644
> --- a/Documentation/devicetree/bindings/mux/mux-controller.yaml
> +++ b/Documentation/devicetree/bindings/mux/mux-controller.yaml
> @@ -73,7 +73,7 @@ properties:
>      pattern: '^mux-controller(@.*|-[0-9a-f]+)?$'
>  
>    '#mux-control-cells':
> -    enum: [ 0, 1 ]
> +    enum: [ 0, 1, 2 ]
>  
>    idle-state:
>      $ref: /schemas/types.yaml#/definitions/int32
> 
