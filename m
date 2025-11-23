Return-Path: <linux-can+bounces-5616-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48AC7E191
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 15:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32C93AC557
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607862D73A4;
	Sun, 23 Nov 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="E5+y20L0"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011037.outbound.protection.outlook.com [52.101.125.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1E25D527;
	Sun, 23 Nov 2025 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763906774; cv=fail; b=oap1tnd0nacRsdftcC6x1vGAxgaEBC28j7H4ejtYE/12CoFS3L6+jBK5ifDnZU0CMshfepiVDygGIwSKdPBgnGmk+Hzxc+DLMzl/IQ5uOIAGA6dnp73HzMUnVGQS6xFu79XsyaGbjTieeZUopTv5a/7/qkmkLhv8kXL38qHyhcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763906774; c=relaxed/simple;
	bh=RzKigNu/2UO+yIzH8wc8dXoMnwCarjCv/UvOes4QIRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TeDR6Z+B1GvVBIZkKP5ohDciuUOC7h5QaDF8YsBsTyHAJL2Vp90pSDR4u2I2DXFA1hbbxFh5GTnRD3M25d0S7AyoisD8XJI2Q8afOlnDZGkwGyvBu4lPpOxHoOzDUDimi1YeQNKZYdYyOhcU4z8ZcrW2OdxBsnyOUGnFai+wbjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=E5+y20L0; arc=fail smtp.client-ip=52.101.125.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIfCUQ2GFnh5Jgxmgl82UBK0hI2/XtthcKnUezNK8mEWJXUmcUVVJ9jE8SuHLjXYFN+7/FuBBBbd4Is4cuDB39Y4Kf6UjBpMP2AFUnvfQPNJ6Fv/Apdv5T+xnb/YGm5JXmvSo/DRPML9tgp+F5OPoft47kk1i8E6IFYFn/PhZgDFIuQPVmE8R2G5MtakbRv1FLVQvqg/zcISsoWRitKkb5RSNt4nDzHGcImPBoudh6DutSOeJ3dt/YhUosrvO/8OOxAIe2K+ENMOwNSDKk+80R+FCBV09IaU0VLj+pG/W4bPcIMfnwCFIv1J8wav43PrZLEzsEv5SXjYflu0pF7CvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzKigNu/2UO+yIzH8wc8dXoMnwCarjCv/UvOes4QIRY=;
 b=TY3kESWeX/Wm9Wm1TmzBVA+Trny1NwOb74fVHv9HfWoMNEJbahW8pvS3zTzTYB9kCHl44fPCT3tEAvWy9T9Lxvxo3LtlhS/uPjoUM4qyCfc4DHNvFFOygrv+GcsMieKEkJ5kEzCCHSm6kCPN1hQe9/hACzpMXy2xvRnRPro8BbQ6oTh+rw9MzyRtZXxY+iWL4gwwIIUY33fTs//fcjRzq12uk3OhcgZu3kszFSc1ZUO9jz4+lBKUa/DpNmDxz7GmaRnnJbrBbpcRwTxsdH49XhkG8yeE0U0F9Dso1gKwQmVA6BzgUikZTSsy0m7sBB7hzJ3pCioHkEXLYBJtXoiirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzKigNu/2UO+yIzH8wc8dXoMnwCarjCv/UvOes4QIRY=;
 b=E5+y20L0QEJ75oKwWiRqQtpsgFNuZPc5M6gP6/AngmYf0WJUpKuxTQjxT6jOww67cg1bT2LSbALxGVoCgMyf3Kxot0u0BhkR967OvCcm1g1Hu/gEPKT6kWj3N/zfYEjCS0OV0OoELntrCCzWqz2oFYNrOjMH+D2LE8nw1WW7tZg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13208.jpnprd01.prod.outlook.com (2603:1096:604:34d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.6; Sun, 23 Nov
 2025 14:06:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.007; Sun, 23 Nov 2025
 14:06:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Topic: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Index: AQHcXGubPTkKPcpfPUaJAr71uDlXKbUAQHWAgAAKwkA=
Date: Sun, 23 Nov 2025 14:06:01 +0000
Message-ID:
 <TY3PR01MB113460EC3CED97F90FE121AD486D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251123112326.128448-1-biju.das.jz@bp.renesas.com>
 <20251123112326.128448-2-biju.das.jz@bp.renesas.com>
 <3928e893-66e1-4873-a78b-75e38e746661@kernel.org>
In-Reply-To: <3928e893-66e1-4873-a78b-75e38e746661@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13208:EE_
x-ms-office365-filtering-correlation-id: 74b5da25-0a20-4583-46dd-08de2a996f1f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2ROVHc0VlpUOUg5VEVZY0thUWhMRjBDTDBGaVhOYldQTTQ3V2hON3dWb3FT?=
 =?utf-8?B?TWYvMDJsSFlNU0x0ZFhMbzRvdXlHRU84RkZ2YTZGSXdYNEg4aitzd1JyQXlM?=
 =?utf-8?B?VUlHZHlVeE9PRDU2V1NNOG1IVXQvTnVyMGtYcjdpWHVUQm1BUndVa1JtY2Nh?=
 =?utf-8?B?UzZ0NFYxcE9DTG10UmNXOEl1bHFYTGxNWWg3NVVWZjdUd3F5NERkQTRMTzFP?=
 =?utf-8?B?dHBQQ2tvMkdNdmJnUXdXTmNYd0cyU3YyUUQzeTJBaERQaktXNlJ3S2NSdmk1?=
 =?utf-8?B?ekt4Y2s1N1EzcnR3SmJvMFhRbzVrNGlibHNoR2NZWFpTd2dweWJhN2M0SHdZ?=
 =?utf-8?B?SXByaVlBaDJ4aXBKWXRqKzZLbXZndU1EUVNaVXZvS0JvU3d1Q2N4VXVUUGJj?=
 =?utf-8?B?RTBvN2o4S1VZRUt0V2xlSUpsNC9wdGZLSWUzd3UyK0RTYmJCS29ldEMwUmN5?=
 =?utf-8?B?UnNiL21ILzdJbU1JM2dvYzRKNVBpemhmT1B1cGs2QUw2SU8zcFd2eWhqOTJ3?=
 =?utf-8?B?RTRVenBMeW94bWtUT3hQKzVQNTVCcG1rQWxVMFdjTHBoT3hLNENJUUNRTjRU?=
 =?utf-8?B?OFlweDFlY2FIaFE3OWlNZGxrNWk4ZExhaWZiUVB4amNUNW1zOTlQM0tJaGt5?=
 =?utf-8?B?eDBpL2w1YkpWUFc0L0pGQUhOck9JYlF0M2laRWRWSzhEa0k5WlNLMkNkbmxk?=
 =?utf-8?B?NDNSSWVUdkhtWG9VZjVmdEYxUmJyTVZOQmF5K0pKU09tMldjakdveWZUNnVq?=
 =?utf-8?B?RlNpSk9sQitmSS9MQmhiVTh3VGZqVk1oT08zd0FsWTJxWkVhTFdkMzZUL2JY?=
 =?utf-8?B?YnFveEw4bCtGRmJ0V3RCYTFSMEh4MThnVlZJVG05Z1MvNWs1K2dycjZtWkxy?=
 =?utf-8?B?UzNjdUF4QmJ3ZkpEL3FweHByTFlSZWZMenFjeUY5SGh5WXJmVDN1b29nbi9i?=
 =?utf-8?B?NkNEc3Q3NDNvbkxmVHBzS1A3RmQ0blN5SmpRbHpDdzZPQzRnVEdIMVd3TXFZ?=
 =?utf-8?B?N0tYVDRRTE5ZaTQvSjRENS9uV1ZpNWVPc2FzcXFhTkdYSVNpeEJSU0VuS2Vm?=
 =?utf-8?B?VTZlR281YmgyVXJ1OUdsSldDT0VsZFZiSTJzTTF2VTdlME1OY1A2aE8wVWI5?=
 =?utf-8?B?Ym0vMXVpT1Jsc28yZEhXVlhEOWYwN1Iwdzl1RjJGUnV6Mk0yekdET3diclIw?=
 =?utf-8?B?RGlVM1pDU203R3BjOERMUnhKV2RFS0JHdStpUmUrdUtoSXVUbERjaHJSMytm?=
 =?utf-8?B?Ly91MDhHS1ZvbDh5andZV2w1elB6blBmU1dkR3hiNGxlS0ZQOU1XOHA0TG1K?=
 =?utf-8?B?NWV4UG5oMVp6VHpRTG5TblpoU2FlNG4xRGF5RmJBNzFGZXorVzlZY3JqMjUw?=
 =?utf-8?B?eGJEMzFBTGREaVltVGxIRXh3RDB3K25VTW1WQVlVT1lqV2Q2aGFYVlN5amN6?=
 =?utf-8?B?YVV2S2Y1MmFmSURpekhvK3VHa21ZQmdjQVR3SFNTTEw5WHRkdzJJRHJzZFgz?=
 =?utf-8?B?NGdCVm1TSXJsYzM3b1B0RWVPR3VYd0JSMEREQm1xM0prZFdaR2pYZXhqL0t5?=
 =?utf-8?B?RkwrRmk1SFlaQ3ZRU2h0amVkN0RuaUU0M08vK25FbllVbzVFQnlEWmpPSnpu?=
 =?utf-8?B?RUJwaTR3U3dlUkE1eTFWUFk3eWw3aUNYT0JuZDNWWlc1ZnlEVUg2RXVJcGpu?=
 =?utf-8?B?amdoTkRjNlZsbWtqZ0paSUJueFdCYW1QbE12eldEaDYwV29UOUhYSGFpQnhh?=
 =?utf-8?B?SDYvL1ZyNnI2WjdVc25XVkVLVHVxQUYvcXFmWW1NTVMzOXRQWW5JM28xSFNU?=
 =?utf-8?B?VmhURHdsYk9pMjR4dWVINGMwbTc1QjI3anQwOGg4Y3FrOFBtbTJraldkUnhW?=
 =?utf-8?B?UlBEUjJxNGpnK3Y1RUExZ0c4dUQ4c0RqYVZsTFZMTUFYdTZaeVNHQkVVTENV?=
 =?utf-8?B?V05hSEV0ak9tMFNZWElqYmNsU2lGdDAwL2VnTGdSYU9YRVBtVHBZUC9wYXBD?=
 =?utf-8?B?Z1RrSVl1SHQvbllua1Jqb2JBUm5yWlh6TDQ0c2NuZUJLZjhvY2dtVFhFNWhm?=
 =?utf-8?Q?FVNoBi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bENMWDFHdHZuaTRnRHB2RU5kakYzYi9vOCt2N2dCdkRiNXFmY0xkSFRTLzBL?=
 =?utf-8?B?M3NnZkVHSGkvdk10eWVyLzRQUVQ3MXpFbUJwbjVIaEc2cWRORXc1RTZLMkJC?=
 =?utf-8?B?NHNNTlFZeEpIMm1QT2JEbUVLQ3BIcm55dFZYQS9FeGRuL084M1Y5d3VtYU5D?=
 =?utf-8?B?aUVFa0xBK2xOaSswTVdFaTNhVVQzL0JVa2U3bjRnNXpOMy9ad0w4aUgzb3lJ?=
 =?utf-8?B?TWprUFIvOUF5bHc5RHh6YmdWczgrTXNNc085bzRQR2orZ2wzLzRSUEVPTHNw?=
 =?utf-8?B?dGxuSjBpdW8yYTF6Vkdaak9IY3ZuUDNsWjl4SFpHVXlYRXlzOVNyMC85VUdP?=
 =?utf-8?B?RERFOVlucXQySVJlcmZQQWtiSGswWmlldFk5eHhOMzlFSXhRVHFvclVmSERn?=
 =?utf-8?B?cjQyVGhDajJyQUlNQjNQaTZ2bUJtRHdVOStMajRFOFFlWCtUcGdaVFBuVU03?=
 =?utf-8?B?MXlCQjJRUnhqdVR2Rk5OUlFOOUFYQ1N0eno4WGdKQ25QZXV4amNOWndMYitj?=
 =?utf-8?B?MzAwWXJqZTFnSklvS3lnTHE4ZUlvdEoxTE5pdzB2bmhMbjNBWGo3ZTJkd2Np?=
 =?utf-8?B?eGlYS3ZhUE1kaHhKRmFXeEZtZ0FmZTZIUWFJYXQ0MGpsdmFKY0tSR3RKRlAx?=
 =?utf-8?B?YWdHNm9yVitnZUFJaGRsNWUyMXZlVWNQakRuNGpDTy9Tenc2cDFobHU5THpi?=
 =?utf-8?B?WmY4OXRPUVNRTzBDREhqNmRKekdsRC9mQzJUd1RTSEg2czFXcndhZUxPMGU4?=
 =?utf-8?B?SDlFYmxORVYrMm1iNUk3Qms3T2F6c0M3YjZBTFZ1S2xpT3g1L2xmakxIdXh4?=
 =?utf-8?B?TmlyTU9Rb1dMeU5HSGQ0cjlKOFRqeWpDUisyU1Jac1pYTjdzeitxV2N0Tys3?=
 =?utf-8?B?Q0FlNzMrcWNPblBsMkVGSlo5bkF2aHk5cHUza0FSR1grZDIzNlgraENKWDJp?=
 =?utf-8?B?SjVuYTFwT0dvaG5NdkZaTlVDNUoxQ0xaRmp2YzIvcEJZSVF2VTRSYjFDbjlF?=
 =?utf-8?B?VU92Z3FEblRpWG9uU0hrWDBNYlJpQXRjeForMkpOaTFBM1FJWDR2bEY2SXFz?=
 =?utf-8?B?bXB6eTZoTEFPeG12UHZxYjlUZW1KNytpeGQyZ2VCK09yY21abU9oMjBCRy92?=
 =?utf-8?B?cFFxUUZUNnk2MzA3OElkdHpiRmlPOWFWcFlJdzcrS3JqeEhzcUUxMUNjM0E2?=
 =?utf-8?B?dFVCQlJXbnBjYmsyeUtNRTJESWs4N0pkSFBRYU9jajRXdklDNWxVOWZtSnBz?=
 =?utf-8?B?L3NObTFFM1lMQ2xteFdIWlg2UWlpWmVxeGtPUktEMDQ3OUR0WFc2VmhLd1VD?=
 =?utf-8?B?MHVFVTFod00wc3J1aEpwZkxSdFIyM1REeDU4OGxwdVhFU2dwQTJ3ZU94Zk9L?=
 =?utf-8?B?OWZXVGZCaXgwa09BY3FFY0xXMTEzUlBuVHFCdVJaVFg0c1JnWEZBaGYySGk3?=
 =?utf-8?B?U1ErV2E2Qm9VaTNLbks2TmQrbFlua0F0ZG96d3Q1UVZYeXpxZHRzSzJzbkIw?=
 =?utf-8?B?OTEza1A5eE9YaGM0QTVVbDhDa3pyRUtQaS8yUUY1cWZBalRXeGpvajRuQmtM?=
 =?utf-8?B?Wmk0c3h2UkJmNkJQSW1hd2UzVldFVmg2UVBaNFlhcDBLenVxd2J4RUpqeVlW?=
 =?utf-8?B?RlpIeC9vK09VbnphbnJNdmo0QXRmU1k0aVpaK09ZSk1lcURhMWNzVDladm5S?=
 =?utf-8?B?UUUvMDI1NjV6T3E3M3pmWGtQSzE3dk1IM1B2R0pObWwybVJUeERQRTNLVnV5?=
 =?utf-8?B?WXVTa1JZckV1bTg0S2JsSE1KTUNOWkJJbXlsRzNzNE1Pc0JvajRYM2ZWM1JO?=
 =?utf-8?B?QXFwOG1uc0cya0RqNUxlQ2J4bkZuSXpPeEhvTHZUUU5UNmRVTnd1clg1T0Z2?=
 =?utf-8?B?ZTVXT01oY2tsQlhtZmlqdmoyWXlvQU04WkJ5QXpzcVhrV0Z5SjQ2UE9FN3hK?=
 =?utf-8?B?azlvU0ttT1JQS0pvRXR3WnJMbVNPWTV2TmhjblNrdjFIRnBsUWlCMXNMOStK?=
 =?utf-8?B?TWtBS2xkU0Z1ODZ4OHJwdmFqMkxkVmlMaUxQME41OWlxb2ZkSVBlOElLYlgr?=
 =?utf-8?B?VEhyOG44b2IwMWVER3NYYkcwcURISXo2MFZEcG1jSGpvaUJMV01jWEF2V3Vi?=
 =?utf-8?B?YTh0NXpoeGZhaFNJdWo3ZFRlRzlFbXgwUnZ5RnZzSmxVSURWbXYzV1AxeWxM?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b5da25-0a20-4583-46dd-08de2a996f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 14:06:01.5305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhlgbifykiVKkXZiyQciZIsAl1X28AILWyr2LaXanGQJeeLdxcE8ghac2QMTu0ZnAYOO7xfIG1/0T3W2yPnPsgYs+/d9N50Uw7kecPewBKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13208

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMyBOb3ZlbWJlciAyMDI1IDEzOjI2DQo+
IFRvOiBiaWp1LmRhcy5hdSA8YmlqdS5kYXMuYXVAZ21haWwuY29tPjsgTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT47IFZpbmNlbnQgTWFpbGhvbA0KPiA8bWFpbGhvbEBrZXJu
ZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yDQo+IERvb2xleSA8Y29ub3IrZHRAa2VybmVs
Lm9yZz47IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+OyBtYWdu
dXMuZGFtbQ0KPiA8bWFnbnVzLmRhbW1AZ21haWwuY29tPg0KPiBDYzogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsgRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8u
anpAcmVuZXNhcy5jb20+OyBsaW51eC0NCj4gY2FuQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJh
Ymhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IGNhbjogcmVuZXNhcyxyY2FyLWNhbmZkOiBEb2N1bWVu
dCByZW5lc2FzLGZkLW9ubHkgcHJvcGVydHkNCj4gDQo+IE9uIDIzLzExLzIwMjUgMTI6MjMsIEJp
anUgd3JvdGU6DQo+ID4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Pg0KPiA+DQo+ID4gVGhlIENBTkZEIG9uIFJaL3tHMkwsRzNFfSBhbmQgUi1DYXIgR2VuNCBzdXBw
b3J0IDMgbW9kZXMgRkQtT25seSBtb2RlLA0KPiA+IENsYXNzaWNhbCBDQU4gbW9kZSBhbmQgQ0FO
LUZEIG1vZGUuIEluIEZELU9ubHkgbW9kZSwgY29tbXVuaWNhdGlvbiBpbg0KPiA+IENsYXNzaWNh
bCBDQU4gZnJhbWUgZm9ybWF0IGlzIGRpc2FibGVkLiBEb2N1bWVudCByZW5lc2FzLGZkLW9ubHkg
dG8NCj4gPiBoYW5kbGUgdGhpcyBtb2RlLiBBcyB0aGVzZSBTb0NzIHN1cHBvcnQgMyBtb2Rlcywg
dXBkYXRlIHRoZQ0KPiA+IGRlc2NyaXB0aW9uIG9mIHJlbmVzYXMsbm8tY2FuLWZkIHByb3BlcnR5
IGFuZCBkaXNhbGxvdyBpdCBmb3IgUi1DYXIgR2VuMy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiAgdjEt
PnYyOg0KPiA+ICAgKiBBZGRlZCBjb25kaXRpb25hbCBjaGVjayB0byBkaXNhbGxvdyBmZC1vbmx5
IG1vZGUgZm9yIFItQ2FyIEdlbjMuDQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9uZXQvY2Fu
L3JlbmVzYXMscmNhci1jYW5mZC55YW1sICB8IDI0DQo+ID4gKysrKysrKysrKysrKysrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yZW5lc2FzLHJjYXItY2FuZmQueWFtbA0KPiA+IGlu
ZGV4IGY0YWMyMWM2ODQyNy4uYTUyMjQ0ZjBiNWQxIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vcmVuZXNhcyxyY2FyLWNhbmZk
LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nh
bi9yZW5lc2FzLHJjYXItY2FuZmQueWFtDQo+ID4gKysrIGwNCj4gPiBAQCAtMTI1LDkgKzEyNSwx
NyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgIHJlbmVzYXMsbm8tY2FuLWZkOg0KPiA+ICAgICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+ICAgICAgZGVzY3Jp
cHRpb246DQo+ID4gLSAgICAgIFRoZSBjb250cm9sbGVyIGNhbiBvcGVyYXRlIGluIGVpdGhlciBD
QU4gRkQgb25seSBtb2RlIChkZWZhdWx0KSBvcg0KPiA+IC0gICAgICBDbGFzc2ljYWwgQ0FOIG9u
bHkgbW9kZS4gIFRoZSBtb2RlIGlzIGdsb2JhbCB0byBhbGwgY2hhbm5lbHMuDQo+ID4gLSAgICAg
IFNwZWNpZnkgdGhpcyBwcm9wZXJ0eSB0byBwdXQgdGhlIGNvbnRyb2xsZXIgaW4gQ2xhc3NpY2Fs
IENBTiBvbmx5IG1vZGUuDQo+ID4gKyAgICAgIFRoZSBjb250cm9sbGVyIGNhbiBvcGVyYXRlIGlu
IGVpdGhlciBDQU4tRkQgbW9kZSAoZGVmYXVsdCkgb3IgRkQtT25seQ0KPiA+ICsgICAgICBtb2Rl
IChSWi97RzJMLEczRX0gYW5kIFItQ2FyIEdlbjQpIG9yIENsYXNzaWNhbCBDQU4gbW9kZS4gU3Bl
Y2lmeSB0aGlzDQo+ID4gKyAgICAgIHByb3BlcnR5IHRvIHB1dCB0aGUgY29udHJvbGxlciBpbiBD
bGFzc2ljYWwgQ0FOIG1vZGUuDQo+ID4gKw0KPiA+ICsgIHJlbmVzYXMsZmQtb25seToNCj4gPiAr
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4gPiArICAg
IGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBUaGUgQ0FORkQgb24gUlove0cyTCxHM0V9IGFuZCBS
LUNhciBHZW40IFNvQ3Mgc3VwcG9ydCAzIG1vZGVzIEZELU9ubHkNCj4gPiArICAgICAgbW9kZSwg
Q2xhc3NpY2FsIENBTiBtb2RlIGFuZCBDQU4tRkQgbW9kZSAoZGVmYXVsdCkuIEluIEZELU9ubHkg
bW9kZSwNCj4gPiArICAgICAgY29tbXVuaWNhdGlvbiBpbiBDbGFzc2ljYWwgQ0FOIGZyYW1lIGZv
cm1hdCBpcyBkaXNhYmxlZC4gU3BlY2lmeSB0aGlzDQo+ID4gKyAgICAgIHByb3BlcnR5IHRvIHB1
dCB0aGUgY29udHJvbGxlciBpbiBGRC1Pbmx5IG1vZGUuDQo+ID4NCj4gPiAgICBhc3NpZ25lZC1j
bG9ja3M6DQo+ID4gICAgICBkZXNjcmlwdGlvbjoNCj4gPiBAQCAtMjY3LDYgKzI3NSwxNiBAQCBh
bGxPZjoNCj4gPiAgICAgICAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgIl5jaGFu
bmVsWzYtN10kIjogZmFsc2UNCj4gPg0KPiA+ICsgIC0gaWY6DQo+ID4gKyAgICAgIHByb3BlcnRp
ZXM6DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPiArICAgICAgICAgIGNvbnRhaW5zOg0K
PiA+ICsgICAgICAgICAgICBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gcmVuZXNhcyxyY2Fy
LWdlbjMtY2FuZmQNCj4gPiArICAgIHRoZW46DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4g
KyAgICAgICAgcmVuZXNhcyxmZC1vbmx5OiBmYWxzZQ0KPiA+ICsNCj4gDQo+IFlvdSBkaWQgbm90
IHJlc3BvbmQgdG8gbXkgZmlyc3QgcGFyYWdyYXBoIGZyb20gcHJldmlvdXMgdmVyc2lvbi4gQXMg
SSBzYWlkLCB5b3Ugbm93IG5lZWQgb25lT2YgdG8NCj4gcmVzdHJpY3QgdGhlc2UsIHNpbmNlIHlv
dSBhcmUgbm90IHVzaW5nIHNpbXBsZSBlbnVtLg0KDQpUaGlzIGlzIHJlc3RyaWN0aW5nIGZvciBS
LUNhciBHZW4zLiBEVCBiaW5kaW5nIGNoZWNrIHJldHVybnMgZXJyb3IgaWYgJ3JlbmVzYXMsZmQt
b25seSINCmlzIGRlZmluZWQgZm9yIFItQ2FyIEdlbjMuDQoNCkFtIEkgbWlzc2luZyBhbnl0aGlu
ZyBoZXJlPw0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K

