Return-Path: <linux-can+bounces-4250-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF29CB28291
	for <lists+linux-can@lfdr.de>; Fri, 15 Aug 2025 17:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F0C188B14A
	for <lists+linux-can@lfdr.de>; Fri, 15 Aug 2025 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910A1EDA09;
	Fri, 15 Aug 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="gzagxJVu"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021091.outbound.protection.outlook.com [52.101.65.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58931E8836;
	Fri, 15 Aug 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270145; cv=fail; b=rncXQJCcHydWNP7z7Tep3ooBqTHE6SbkTgNcQREqsVWY6TdTr6LaXAeDMWqaO3AjP+Ubkckpk7wHa7U3ZhElowKHTDzvqoaybMqh3sIxpPYad0iZotbWKRI2RpmrtSlRGq0HhgAUrdzznssoljXlTHofYoEIHoU9ZNtRg8wf7b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270145; c=relaxed/simple;
	bh=S8NsOTUYYsuNRcfmUlin0irkLgdwz1MwAByXeT6QGOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKWu0vwl31HxHMCfsBV6CrsdfYQIC4C6kAKd3PP5NfGmczCdG43hKx3qeQJxrZ3hZ6lb4mX5u9tPEwNDn71QjS4vwMI8uKrlaeQKdWKVXtBa9ZWj9kwRtUslD0D2uv02/KDDQfO90Q49R0oDJrw8nK3bSdhB47egvSN/caguz7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=gzagxJVu; arc=fail smtp.client-ip=52.101.65.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhMrm41ZR+hzwBQuQ0kOgW4HK59ZWJ6Fd9f/tCLk9W3G5g130/LBfS/CzU4z2jZdgcc7LflSTDpoSELRccb/33Zs3ETWnutoFb9RcmXp14UqKG+/JanmOA+7RqeDO7VORDQi5Fe2Kjv3PODX2B0dnkM84UeQf5YJKK81s1uNtvhD1M5PitukdZtwV9YVEjto+FmfaAMhdHaq8FSUbU8JBheg/liT1Y56ZrDzjkFdO8jzH7+EfgarxgwLAoDhPDZkjwmS8l6WYO9z2PP2yPTLQXsS3gOAIYdkR68wEVsDa7k0hUdCl4hkaIZLh4SmDIlqRNG5vn4T/3E1/MbuZgQt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8NsOTUYYsuNRcfmUlin0irkLgdwz1MwAByXeT6QGOU=;
 b=XKqlHF2whvGx8urrFx2FsEyEiftrUETiyYie/jso8NB8n8BkhvQPMwUWWvIWBP3OEKSEP8OHDNEtS3w4UyP5FIMEWTCi+S/35Mbq6t3Q8UB8MzKDPUptVzfisvtuEhMPEezxVZM8szict2DOMIrWsQJon4WfOHFCCC4FVh4e+oTH+tU4ic4IVCZXywSdhvpG2bwzIm4TpeQ0aL1To3gpBm3IJikSUXBNQCds/78CEAqla/KPcBZTzU8x2EvobbRraEZh7rf+ODUZb8UPUQJRpkxFXLYplFgO48I+zyyddwgRhmlkKUNyuMVbZTJmaRwE732kFDRc5pPi9WpH6v4jMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8NsOTUYYsuNRcfmUlin0irkLgdwz1MwAByXeT6QGOU=;
 b=gzagxJVuVUzfSpXtjaec1S1ICPzJTd96tPwA9OuGO9PuYDurdV7j6g7GOkhJfn2suQf3wej/Syk/pBTBerIjlduhvC6485TPEAGISnIoizuHMS97UwloPGWaLEifKtXuXwepXjrXEIIt6zKlyad4SyjXoJ4mzGNYPqYPt1Fz9I8=
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 (2603:10a6:150:161::17) by AS2PR03MB9646.eurprd03.prod.outlook.com
 (2603:10a6:20b:5ea::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 15:02:19 +0000
Received: from GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f]) by GV1PR03MB10517.eurprd03.prod.outlook.com
 ([fe80::cfd2:a2c3:aa8:a57f%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 15:02:19 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>
To: "mkl@pengutronix.de" <mkl@pengutronix.de>
CC: "mailhol@kernel.org" <mailhol@kernel.org>, "socketcan@hartkopp.net"
	<socketcan@hartkopp.net>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, socketcan <socketcan@esd.eu>, Frank Jungclaus
	<frank.jungclaus@esd.eu>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "olivier@sobrie.be"
	<olivier@sobrie.be>
Subject: Re: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with NULL
Thread-Topic: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with
 NULL
Thread-Index: AQHcCwPFrmv+HBR/vUi8Xlz4VVGjrrRgUPUAgAOEMwA=
Date: Fri, 15 Aug 2025 15:02:19 +0000
Message-ID: <f5ac3d3331bcd2403df33be05e0b928cf38c35dd.camel@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
	 <20250811210611.3233202-2-stefan.maetje@esd.eu>
	 <20250813-crafty-hallowed-gaur-49ddac-mkl@pengutronix.de>
In-Reply-To: <20250813-crafty-hallowed-gaur-49ddac-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10517:EE_|AS2PR03MB9646:EE_
x-ms-office365-filtering-correlation-id: d4e74c42-5cd2-448e-8ee8-08dddc0cbb4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Sy9GVlVVYnk0RkhvMDUvNHNmd2pxcitTM3hmUDArSVBJamV2TCtlcGhDTUhP?=
 =?utf-8?B?TnFHSzloK2JadkZWdHBmdmkzZks5NUYyQjBDWGxnT0pFTmFCck9nOEYvd0Yx?=
 =?utf-8?B?RFplV0l5OUZzMytmUG82cEJjeFpVeFBINVl0Z1lQN2VqaTczeXlYRTRCeklO?=
 =?utf-8?B?VDBiWHRZTXFaWnFIb25FWDVMYi9udXZveDEzSHlLV0tXNVRNaTVCUUtrSzIy?=
 =?utf-8?B?L1BlN3NTTzY0OXhKRXVRazI5eTFmMVp3Sm9YbEN6UnBKbGNaVnZsTzVzdnNj?=
 =?utf-8?B?QlYxd1JwdWZ0NUxNZEtqRHlmMVlyNE9hQ0lsM3krVndKWHFuTkJMemFCZ2kr?=
 =?utf-8?B?Y3llYWVheGZWVFBENHVCMkhHYkdKV0NHR2Y2ZHVhVXZQREhtUzV1UEg2TkFT?=
 =?utf-8?B?dkpPTlpTYms0SEJXV2R3MS9hNUtVaWdOMURoM2JZNHRPcFZhQkhXWCs5NlUw?=
 =?utf-8?B?eDVYVCtxU2pxeWtOMUlSMzVoUlNmb2pKZ0xLQXpDdXVBMmovQStkUEowYm85?=
 =?utf-8?B?eVZVNXMwT3o0Q3FST1E0OFl5djR4QmNCVjRaMmViWnRxbkJ3a0c3aTlFaGxZ?=
 =?utf-8?B?cDhPSFNJWUU2cFpjK2ppZmRueitJc3hpcW1lVE5JZjVmREJveS82ZkZNclY1?=
 =?utf-8?B?YWRNWDVZV05yazIrbWpNZVdoMEduTWNxa0h5Y2NZOU9TWTFiYUNrODRHT2Rk?=
 =?utf-8?B?N3NSeVlxQ21DdExTa0NWdTBmVmhNQ0hVNFY5Kzd5YisrUk9XY0xOT25hZjNQ?=
 =?utf-8?B?anNoOSswYkNueVdzMExxREhmUXpBTUduVFExWkNEdkFMWUxlQmJYaGhQaGls?=
 =?utf-8?B?YWZJRkZRbFhkTEtjY3FFSko0U1c5ZjlLWkxyczE1eXVSRDJGS1lvN01HMUNE?=
 =?utf-8?B?Mm15QmNjS2V5MmhMYW52RlJoS0NxMW5DWkZSQTNRTDJ6WXRaKzl2Sk5qS2h2?=
 =?utf-8?B?Z2N2TVUxQ0VtTEU5YnZXaVI5WVBSdEdNcGY5cnd5NHhFR2R4dGlldkNUSjA0?=
 =?utf-8?B?MmlCYyszOGl4SHlTYUNWNUlvQjl1SjlDeEJrU0RZUDdQWEkxTUZiNWFXaTZE?=
 =?utf-8?B?R1IrU0pVYm9oWmx4dkdVSlJMSW9Pc0FMeTdFSkk1QzFHWXJoNVpxNGxydFcx?=
 =?utf-8?B?OCs0MHpvazJYbGxvSW9jMEJxKzdxeWRjSlRlcEtVOStEc3BSRU5JL2VzQTJq?=
 =?utf-8?B?czZKSks0UU8yYURibWFCOXBMMmhLRXRhSVNma1VzOEwwaUxhODcrU2MzalpX?=
 =?utf-8?B?KzVQWEtnZHdNRFRZaVl5elBrL1hETll2bTJMK0dPMVU1ckNYcVhLWFVLa2Z5?=
 =?utf-8?B?Sm9oOEFOU2xmbzFKeHJqMnRBRjdScy96ZDY2MW5LaitjemY2Mzg4c3N4R1FY?=
 =?utf-8?B?bkh4SnAxZzFHQktaZDdTRkZuNithM25nVmRRUWtWSi9vR3NhTmtyaTErSGhC?=
 =?utf-8?B?aTVRNWxqczcrMU8yV0xKazJycmRaL2hyUHhkejFiMDdiTFlESkV2OWEzeGx0?=
 =?utf-8?B?QmJsV1lLNzVkcFU2ZEl0bi81R3dmYzVEU3NTNWpsem5aamcwRTUrcE5iVW55?=
 =?utf-8?B?MTZ4aXZvWVIrdW5PVzIyK3RoK2hCZ2RzMWRMeTN4QVNieFU2eldYWXdjdTZG?=
 =?utf-8?B?NUtvbk9GR1lZOFVVRCtkdkw3aTROeFZ6TUlHemszR2krSVBzYUNMNUp6dTJ5?=
 =?utf-8?B?cjJnY0tlQ2M1dWdlQnBIaUZySEUvcHJpdUI2WWpBd3ZyQU5LRUFUZHlQbk5B?=
 =?utf-8?B?NWlxekZ4M0NVei8rMW9IcVptUEZrdjRrZTBtbzBXMEg4bDRCY0JsUUlMRTRi?=
 =?utf-8?B?Z1daUEtGM2xqK2VBWDBMZWU3ekFBL1Vmc2N3SERROWFpTTdZSlZwNHdLbk52?=
 =?utf-8?B?T25ZTFIvazN3ZmNqRUNmSW90UDM3aHFYSkgySUVFazhQUjcrZk9RSkl2N0lj?=
 =?utf-8?B?ZUlmUitiTW5FR3lORENvS1BtelcrODFSeU9raEtCbk1lZG94eFFJbFNKVURZ?=
 =?utf-8?B?Zzd0UFZXRk5BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10517.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1dLbXowQmdBVjRLVXNtSWdvY1ZhcExhUWIvcU15azE5d1Y1bXpJZFVxTU12?=
 =?utf-8?B?Sk5LWTNicjRmL2ZFMXQwSzdEV3ZFRVBMemxUb2R0WnViakxibkhDSGJobFdk?=
 =?utf-8?B?OTdVRUMrTGJ3b0NUZDA5SzdmL3BNS1MySVNxOENGeXNHK1pEQ1NkaU90cmN6?=
 =?utf-8?B?TXNGb3lVaFFORXBLQ1I3TXhlSmZoQjNoTkNqU2N4aUR2NWdsRnVqZDAzT2Nz?=
 =?utf-8?B?TWhEcHFJNEZtM0I0Rkc4dlRwY28vbzAzY3ZsaGlWdEVKVXJ0ZlFocjJYR2l4?=
 =?utf-8?B?aVM4M09VZWJmeFIxajJENlMrNzNmK1VaR0RNWmtoVkpvQTJ2aEh2NmVETFZB?=
 =?utf-8?B?Qm9jamVvZ1Zmd0piMll0bjZvUUp2NjVQOVJTa01SZng4ZWNvZFRYYVlIK3lV?=
 =?utf-8?B?RTdZZ2VET0twME56SEQ5ZjlkNExhQTJaOHhsQ3g5cEpjZFBta0swVmg3NWFZ?=
 =?utf-8?B?WWp6WW5VeHBHSFB6N1hsMDVOV01yNXFoaDRwdnRyUlBSU1cwOFJCMnBMQUdn?=
 =?utf-8?B?WWMvS0M3WUpnVDZ3djIvYWZMelp2TnJCWUxMVVZXREtXK3lzamk3UGF4LzFw?=
 =?utf-8?B?ZTRFQmhHcUxhVWN3Z2ltNmNvUlo2WHpJNnI5NC9jVEZzdU9IYjU5QW91YVpC?=
 =?utf-8?B?blFYWDRBbVFBVCtRSUpHZ3V5cytGMW9TbEVKZEgxN3BVVk9mYURPaGd6V1g2?=
 =?utf-8?B?VW5yajhOVzhVN1RiaHE3TTJDRkZINEZXYlhMcmY1WkFkdG1EdHNDcnQrL3JJ?=
 =?utf-8?B?V21jYmNNYUY5N0k0VWVIbFc4REVVVVhJaFR5bndwamhkbldtcy8xanpMa25C?=
 =?utf-8?B?RXJGNTdOMUM4WHhsNVFNZUxGTEpKZ2xyUVk1QlM5YWczRldaZ2dXaFpsK01S?=
 =?utf-8?B?d2MxbmxuTkZHTUg3OXFVdlZyRkFSWjR3NEx5eW5WL0xwSHpVWkY4R0lsRUZB?=
 =?utf-8?B?M0FTS1ZqeEI4U3lYMGVNU05yWDAzOEVwNSsya0JZM0dCZU5JK2pCRTRyVlJj?=
 =?utf-8?B?K3ZtK1VCNWRPMDREc0JKNElpb1FLQ2Y4bmdNV0FkeVhNNVRRWGovUmtxTjA2?=
 =?utf-8?B?NzJxVWIvTVU5a0JOOWprcXoza1dxSHc2QTF5MGZndFYzR3BNd0pJTVYzTXdK?=
 =?utf-8?B?anNRcUg2Nm5uYkNPL2ZuUWg4MDJMUGlTeHpLY2xSUTNjRVQzYnVBblRkK2ps?=
 =?utf-8?B?anl3ZWVteXdKY293V21ieGd1aVY5Z1hWeU1zbmI5WUZVZkZidWRzT0ZuelNV?=
 =?utf-8?B?ZDEvbDhvRzhNdzM5aGVnNUt4OXY3aTdJb0NldGNtZUlCZ3BFYjFsK3JXQTRI?=
 =?utf-8?B?MHYvMnJoNWxrRlk3elFhNG5ZVXpLMHB0ekFUYWEyRHV3a0U4cDlrY2plRGFu?=
 =?utf-8?B?R09yL0NLemdmTk0zQ1lDTmU1aVlFb0JDbE5QaEpiQmF3ek5IajdZSGJzZ0ND?=
 =?utf-8?B?SUwyMTJpNDhEVHNGOVRESEFkUzZwUWNPbXpFVGhWYjdCaElVZXJhUUNaVXg1?=
 =?utf-8?B?THFqVk1sZVg5b0V4Mm9BOXl0cmk4SERLNEExM2VFaVhGTlNRc3FyeVF1S2xy?=
 =?utf-8?B?RFRSK3JtUWM0bml4ZlpDcFNzZ0RNTi9ER2VDVHN0cGNaRkRSVWlMYUhZaTk5?=
 =?utf-8?B?MG9tVWZnakZ5aHVlRU4yMVFTSGR5TldjeWd5SVJVNU5qMnZSY2UvMndPTVRp?=
 =?utf-8?B?RUJ0TjA1TXVXQU13M2hZVzZ4b3RMNmNucVpvQ2ZzS1pRWHhBL21zZ1Z3SHk4?=
 =?utf-8?B?OUxpbFczSDNkMUFsQWNaMis2Qk5mcFFSaUo0VU50NWdIbEQ4TmV1ZmpJRVJX?=
 =?utf-8?B?ZzlRWG15aXFwcjBQQ3c1a2RkRUh3alJIdkpSTmF5N0FsWFV3MG9YU1JRVHBS?=
 =?utf-8?B?aDFWT2ExbnBzM1ZSMlBEcy9Hb1NiSVFWYVVnS2JjZ0pPV1VNUE1OL2xtMG0w?=
 =?utf-8?B?MlhFeGw3ZnovUHJoSEc4QXRtMWpiZVBEN2NML1FwQ2R4aUd3a1ErOS9xQVdV?=
 =?utf-8?B?K0pqYk1WU242a1c0U3ZGZWt2NVJCTmQwUTIrQWFqaUhpcXdTVjAyZFdvOFda?=
 =?utf-8?B?K3pQVnY3QXNJU1B2TE15Z0tzRGlzbnVXYWJFdVpkQ0xlNHF5dmVCbkYwOUJu?=
 =?utf-8?B?YlNsdVozVHFJcmtTeU9OdHR5YzhTQ1lua1RMUzFEUmVyTlh4Z01QUVEvMXA4?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32C451ABED595245A07DD42439B86158@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10517.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e74c42-5cd2-448e-8ee8-08dddc0cbb4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 15:02:19.5977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IX3g9pWYeGcpuVRgB9WmZtKyXxJ4DQXmPCtBT6WvSgqR6tIH/a8qzfdNqq8XmOAldeUa51uGByyAPzmPhFhnng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9646

QW0gTWl0dHdvY2gsIGRlbSAxMy4wOC4yMDI1IHVtIDExOjIwICswMjAwIHNjaHJpZWIgTWFyYyBL
bGVpbmUtQnVkZGU6DQo+IE9uIDExLjA4LjIwMjUgMjM6MDY6MDYsIFN0ZWZhbiBNw6R0amUgd3Jv
dGU6DQo+ID4gSW4gZXNkX3VzYl9zdGFydCgpIGtmcmVlKCkgaXMgY2FsbGVkIHdpdGggdGhlIG1z
ZyB2YXJpYWJsZSBldmVuIGlmIHRoZQ0KPiA+IGFsbG9jYXRpb24gb2YgKm1zZyBmYWlsZWQuDQo+
ID4gDQo+ID4gTW92ZSB0aGUga2ZyZWUoKSBjYWxsIHRvIGEgbGluZSBiZWZvcmUgdGhlIGFsbG9j
YXRpb24gZXJyb3IgZXhpdCBsYWJlbA0KPiA+IG91dDogYW5kIGFkanVzdCB0aGUgZXhpdHMgZm9y
IG90aGVyIGVycm9ycyB0byB0aGUgbmV3IGZyZWVfbXNnOiBsYWJlbA0KPiA+IGp1c3QgYmVmb3Jl
IGtmcmVlKCkuDQo+ID4gDQo+ID4gSW4gZXNkX3VzYl9wcm9iZSgpIGFkZCBmcmVlX2RldjogbGFi
ZWwgYW5kIHNraXAgY2FsbGluZyBrZnJlZSgpIGlmDQo+ID4gYWxsb2NhdGlvbiBvZiAqbXNnIGZh
aWxlZC4NCj4gPiANCj4gPiBGaXhlczogZmFlMzdmODFmZGYzICggIm5ldDogY2FuOiBlc2RfdXNi
MjogRG8gbm90IGRvIGRtYSBvbiB0aGUgc3RhY2siICkNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gTcOkdGplIDxzdGVmYW4ubWFldGplQGVzZC5ldT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9u
ZXQvY2FuL3VzYi9lc2RfdXNiLmMgfCAxNiArKysrKysrKystLS0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi91c2IvZXNkX3VzYi5jIGIvZHJpdmVycy9uZXQvY2FuL3Vz
Yi9lc2RfdXNiLmMNCj4gPiBpbmRleCAyN2EzODE4ODg1YzIuLjA1ZWQ2NjRjZjU5ZCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vdXNiL2VzZF91c2IuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L2Nhbi91c2IvZXNkX3VzYi5jDQo+ID4gQEAgLTMsNyArMyw3IEBADQo+ID4gICAqIENB
TiBkcml2ZXIgZm9yIGVzZCBlbGVjdHJvbmljcyBnbWJoIENBTi1VU0IvMiwgQ0FOLVVTQi8zIGFu
ZCBDQU4tVVNCL01pY3JvDQo+ID4gICAqDQo+ID4gICAqIENvcHlyaWdodCAoQykgMjAxMC0yMDEy
IGVzZCBlbGVjdHJvbmljIHN5c3RlbSBkZXNpZ24gZ21iaCwgTWF0dGhpYXMgRnVjaHMgPHNvY2tl
dGNhbkBlc2QuZXU+DQo+ID4gLSAqIENvcHlyaWdodCAoQykgMjAyMi0yMDI0IGVzZCBlbGVjdHJv
bmljcyBnbWJoLCBGcmFuayBKdW5nY2xhdXMgPGZyYW5rLmp1bmdjbGF1c0Blc2QuZXU+DQo+ID4g
KyAqIENvcHlyaWdodCAoQykgMjAyMi0yMDI1IGVzZCBlbGVjdHJvbmljcyBnbWJoLCBGcmFuayBK
dW5nY2xhdXMgPGZyYW5rLmp1bmdjbGF1c0Blc2QuZXU+DQo+ID4gICAqLw0KPiA+ICANCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L2Nhbi5oPg0KPiA+IEBAIC03NDYsMjEgKzc0NiwyMiBAQCBzdGF0aWMg
aW50IGVzZF91c2Jfc3RhcnQoc3RydWN0IGVzZF91c2JfbmV0X3ByaXYgKnByaXYpDQo+IA0KPiAJ
bXNnID0ga21hbGxvYyhzaXplb2YoKm1zZyksIEdGUF9LRVJORUwpOw0KPiAJaWYgKCFtc2cpIHsN
Cj4gCQllcnIgPSAtRU5PTUVNOw0KPiAJCWdvdG8gb3V0Ow0KPiAJfQ0KPiANCj4gQ2FuIHlvdSBh
ZGp1c3QgdGhlIGp1bXAgbGFiZWwgZm9yIHRoZSBrbWFsbG9jKCkgZmFpbC4gVGhlcmUncyBubyBu
ZWVkIHRvDQo+IGNoZWNrIGZvciAtRU5PREVWDQoNClllcywgSSB3aWxsIG1vdmUgaXQgaW4gdGhl
IG5leHQgaXRlcmF0aW9uLiBUaGFua3MgZm9yIHRoYXQgaGludC4NCg0KPiBNYXJjDQo+IA0K

