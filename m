Return-Path: <linux-can+bounces-5117-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F65BC8061
	for <lists+linux-can@lfdr.de>; Thu, 09 Oct 2025 10:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9CFA4F5A83
	for <lists+linux-can@lfdr.de>; Thu,  9 Oct 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED382C08C4;
	Thu,  9 Oct 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IfgCa6l8"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495432D0C9C;
	Thu,  9 Oct 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998114; cv=fail; b=XmoqBgKizr4aO/yEVmPh1jhxmq5VLlt6s3y8uqREK5tUQbZPLImZf8ETfxUyZZIBMxEPXzIVXvx/n7V6EMKFA2tDushpv4Fl98Hv8ipNxBQ7fM9T3IAj96EgI09HYSPeuBnCXqzJciRm/jujB10YKb/X92PwhGQUZzN0Z81KUgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998114; c=relaxed/simple;
	bh=XeTK7w+ahiXLnFSxu7eGzzYunS2U8BEes8A6aBTmIu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BX4Q5jaXbvmsfIIbf/5h9DHdW/RsjQvsdM1RM2G3GYI1gjD4w8uI2JbGFWdKz07pq1W5mlJIGpYKcEwNY7nKz2jANo02hXQMRnKFSdbNVgQ3N6XHzLJrkHvWG1mnELZQT4/KYAGhdmuxj3NsarYI5rWln4JJMerYEPghtj/WrjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IfgCa6l8; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0dnWYGoMZiD1VRoe9G4GmQYRBUyBxbTiK70pFRs/KBH8/8T/76Ogu+K3cJ/GoKabwbb42Pg/aRrtllj+bJlBgiT0dqAgg3EIcEv0kMFGyPG8sA5dqmlqBg8EaWLJVGj02HL8Xl0jnhuX+2l7bBZv1Swkix8W+VmrKKJznMJ3mCnktw6J3rLfFB+OtrM9RtkRRGT6jM7Di6fMfGmzPI3g3mR1JhgbaGlYHm4p0vvNxa6kJnbh1iUy2r/fsRPrVoindIaIqrr1T0oRTuNvisrzH1oQ0hh/ZBh9SGi+xGfz1HbGex5YQQaoJKx9TB2LfQjrKvQ6JgdpA3DnHgjLCGKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeTK7w+ahiXLnFSxu7eGzzYunS2U8BEes8A6aBTmIu8=;
 b=YU3fbXCT6pUIrBN+E8Pidm4i1CTAUhmJnhNrKVmAuuRpSzDV9iOgzcqljRgIFhI1H78KaKaayHM5Wck33DSkcdCjmG+sK9waorgBKSfFckvW4mDW3OWOc+3tu9Eo+reZ8A6mxrDMqRUBJHloMaSeNPwRcOGIsjcglRU0+dOh2xK/X/F+ZE5v6nc0Dih9Ob8Z9RsN5yujUMGsNucEZX2NFfI+iDvYuQcKV3Q8E0dvlGlHAWJF7ovGvOxP/U/I9lrQXEi9lh7dvdE1KQGGYhqf951DDpFDdkYsVr1/W6i8sEAs+J8qrgVCs89zQSiv1eE/y+wyFTWrgl/DHvAkO7qzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeTK7w+ahiXLnFSxu7eGzzYunS2U8BEes8A6aBTmIu8=;
 b=IfgCa6l8qJMJZWq1Xfy4xKg1FYFY3MV+pXqzX/+0XTeAXYhFfpJrv4AckP9gHnvImApaoFD4dwxBnHk2p/nOCiPVIKmf5fuTfn0fTOBruVdR0JmTPhrkyyFmHZJBGKVbBMrsFUtu+9tsvogmxGq8o4bgE60j8RUe0go/rKD05wh84fddfCfmLO/qLcCroFkFWjtJ0ObflLH24K4g6J6/O5yHkmvWERnc9Yp+KCaXs5lYHYBGbYrJYJ63Jwn44n1dHNHpqVxlGvI78tKJv4WIPBTF/Swape0Nys8ayM9U/FqsQzzOIhFVht1Zv/ry4xp+0H8r/MyLpAIJxtd3xyXAUw==
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 08:21:46 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::43b2:647b:5320:225a]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::43b2:647b:5320:225a%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 08:21:46 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Chandrasekar Ramakrishnan
	<rcsekar@samsung.com>, Vincent Mailhol <mailhol@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] can: m_can: replace Dong Aisheng's old email address
Thread-Topic: [PATCH] can: m_can: replace Dong Aisheng's old email address
Thread-Index: AQHcOPVHMQW7/29K802OGdoX+sCmiLS5eOTQ
Date: Thu, 9 Oct 2025 08:21:46 +0000
Message-ID:
 <DU0PR04MB929938F9D13D84140424C6EF80EEA@DU0PR04MB9299.eurprd04.prod.outlook.com>
References:
 <20251009-m_can-update-email-address-v1-1-30a268587f69@pengutronix.de>
In-Reply-To:
 <20251009-m_can-update-email-address-v1-1-30a268587f69@pengutronix.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|AS8PR04MB8404:EE_
x-ms-office365-filtering-correlation-id: 5a7d3026-e001-4092-786a-08de070ce317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?WEJuNUtHWVRubkRvZ21HSFNHaTEzQ3RkaXloUWhWUWJUZGNKL0w5TE5Wb3ZU?=
 =?gb2312?B?V0lwY0tDU2JGZzFVYTdkMzF5WkVWZDc5cm1hSWU4LzhNblhMWGxNaTA1T0Fl?=
 =?gb2312?B?bFAwV2FjcGxEd3dlaUE1KzRZM2loTkpBanFOeCtrNXhLMkp2T3dEZVA3aHJU?=
 =?gb2312?B?WVVNSXhQcXpaQWd0WjZzZGR4eFNxejhadnRteTVPUHp3RGhMeU5OK0QzdGtE?=
 =?gb2312?B?ckxLTURRTlUvZk5iRVNrYzNCZVBRT0NnUnJ4NmMwRG10UnFXTHV2TmFwRTZk?=
 =?gb2312?B?Z0JjcHFueWx0a1BiSVJZbVdna2xaRmdoK2RBNTgwTE00Ymxha2Rjc3hGMGha?=
 =?gb2312?B?eUZSMnZqY3JMTVlwZmlNZVplL1VQRWw5bmYzUFYwQ0pWbGp2S0pqN1FmMEEz?=
 =?gb2312?B?NDh3bnpib2FzMzdkSTBKV05OdlcxVFRkUzlLclRrQi8zWkM3djlJNHVvQjky?=
 =?gb2312?B?bld1WjR4dFh6Y0dBTUovTzlYT050dEpFZGsrY0NxVGZvWWpoN09pTjE2cmpn?=
 =?gb2312?B?WHZQM2NPYk1QRC93WjJmd1lmY0s1czRyVGVSejB4STE3YXZlNmJpMURwc0R6?=
 =?gb2312?B?ajd4SjE4T3pDaGo3clgwTk1rcDZRUGxGWXJmNkpLTmRDZ3doOHBodXc4NnEr?=
 =?gb2312?B?Q0tTNEhDTGpGcm1XZVBzeVVBZ3o1SWJzb3Azcmxmb1dVbFJHL3N5dWU5Z1FE?=
 =?gb2312?B?Tmw3ckt6QjNlYXZMTnRsSHNNSXRWV3ZMY2xERnBxK1VaM05Md3lFcUdONkp4?=
 =?gb2312?B?QUhJTXJRUlhpVHRWbE9Bc2t2dUNmUnduRUNkbFVITHk4UGhOQ3NTZ0lDSzd5?=
 =?gb2312?B?ZldZUktOMnd2dXl3K0ZLMGJmZGVCWUJGeURGSmova3FoRUU2UWc1UVZ5ZEM3?=
 =?gb2312?B?ajhyRkhHaGxYampiY2pUUHlWeFdYMm5iRTQyTkp6ZTRLSitscjFmaHZycjAz?=
 =?gb2312?B?RmVkZkRYZTV4QTlhNTNzYkozMkxSUEgxeHpRbDJld2V2R3JpUGlldmJVYlBK?=
 =?gb2312?B?Y0V0eWdIK3hoNXNPRXQvUVZDSnhVSHJiQjBPWmRKeFMxaGZON3QzcC9DRThs?=
 =?gb2312?B?Y1ZRWEpZK3ZHVy9DemhPNVlNVnBOUnRwcjZMNE9uUlp5SnBvTWxYZkxvbGtX?=
 =?gb2312?B?VlVqM0RvNm5YQVgxbktISlFtVHZpMGsvS1hTZnoyOXkrOHQ3cG96RzZJWHFz?=
 =?gb2312?B?TjhUcFpQY2wzZ3RpVG5yT1R1ajA2cUd5WDZmWVIvaEd1VVluZVpzalBiZ0hq?=
 =?gb2312?B?TXFiVG9kWkp3NEwwWVBFZ0d4cmJlUjdHSHZ4UDdEL0puMUgvUitFUWlWOEdt?=
 =?gb2312?B?OENTU1NxdjE5ZDZGaTBsZTErS0FLV1BXN0dibGl2N1NyZldEbElCWTdyT1ov?=
 =?gb2312?B?SXROQlhzazVRbkY3aWVFYjVZalh0bkl2VmRkWkJJUzUza3NLNEFJcmw3U2xl?=
 =?gb2312?B?OEZzWStXc2s4WTRxQm9Sa3BKTFhlTENPSGlDKzVyaXhZN3N4aVZNSlNLU3dr?=
 =?gb2312?B?cDRnRzcyVnB3Vy8wL01WV3MybVZoS0t1dUJ0bWF5Rys4dzR1M2U3WlpEWjl6?=
 =?gb2312?B?eDBid3Bick02L2I1THAzQ0JQQ2ZUSldSSDBMTmtuWXJkcTRmNFNvTXpLNkNU?=
 =?gb2312?B?YU56YlR6UDZLZUIwV2wxSEFmYTZ6WTNmN3VVV0pOckNiTGRHWjhwbnpUVkV6?=
 =?gb2312?B?d2JYalBDRkZ3RFdVUkhDMHg2ZDJWOFFVSUNxeGZ0NmtwTGE3N2hvY2tGSWxu?=
 =?gb2312?B?Qk9VR3RMZm83Q3BYQXNBdXQzWE5zM2lvRWRwV1Q5c3k3MWJpdGF3akxoRHhj?=
 =?gb2312?B?MEZxZGp3c2ZhZlVEYXpLVkpjZ0szTytyakFHNTN1TWxNMTNibTZzR1YraHpx?=
 =?gb2312?B?eXhFNDJCUGsxZ1UyWVFZYzA2NWFuc2t4b2dZeEpra2VpMWNXRGJ3c1dabUNT?=
 =?gb2312?B?SlVZbjlRUDJzVGxJZW8rTVY4UXdBZGtva1RMTUxjU280OXJxK2E5OHUvOWIy?=
 =?gb2312?B?dWpxL3lxRHBya1A2MDNyeFdYYXNGREVienE3OVhhZUJyaWY1TVN0UitMUHFT?=
 =?gb2312?Q?2ItI6C?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UlRXMGVpOEFORVF5MTk1MG9uQTRCam5aSUNZQ1JoWVJ0NFZSSXRvR2t0cVpn?=
 =?gb2312?B?eG9NMGVNUW9XVTFtNE1pWE1TMWtkWWhPTWZZNTNBb2cydWxHYUVjb3VqUnNr?=
 =?gb2312?B?cHZkd1FTLzFtcXJrOXl5RTZGT250NGEyVGlxdlhVMTY5N2dLNllXSmNaUE52?=
 =?gb2312?B?cVlGYitrY2VlV2Jjbks3cW1iRGxEcWFtWmMyZTFBcHE0OGNQajhJNmgzR2ZC?=
 =?gb2312?B?UkNiT01JdzVYT0dZaWVJTlVoUDE2Q244aC9RVmFQYkwvVWxqTlE0VTlZRmJP?=
 =?gb2312?B?U0JmcnFOVU5LeHVjT0E3MkNqVDRvL0lHNjMzdXJlaEhzVkRnK2pUWDYrMUJL?=
 =?gb2312?B?aFY5cWdpQ280RlU4bUd4SzFXZUJYaUZFN0NEZWxJWDMyTWJnYkZhd1ZtN3pO?=
 =?gb2312?B?NTA0anBuampiVkRJU3ArRmJJTWdiYWo3QXFhUzdsY3pTY3NJZFQzZ3E3UHZE?=
 =?gb2312?B?MWVpeHRoMUhQVVhDRFVYZDR1RHY3cXl4NFdORUtvQzdEanlOMVl3NitDRlN5?=
 =?gb2312?B?cDVsRHA4Um0wdUdIazhZN2g4NUIvdmNmdmtPV0RwQkpVREh4c3o3U1JCd3ZF?=
 =?gb2312?B?YWVjeEZVcXlVRjZWbFBldHBMbTk0czVrYk1ZekhxWWVDbVBVZ2ZZNWNiaHhQ?=
 =?gb2312?B?cG5PSklwSVNBamVMUlJuTGRTNlM4K1doQllrTGVtMHIzY1E4V2Jzd0lMZkd4?=
 =?gb2312?B?Q0Q1Y2NxeTkxc01EelRaK2hTdHkzOVJiN2N1KzNYb3V6Ny83SUhyS3FFQ3F1?=
 =?gb2312?B?cFdqSTQrWlBocVFlbEUxdDRCdFl1OS95dkpuU3pxNjlQVHR2QytzUVJRMGxx?=
 =?gb2312?B?NnFGQVpaRkxlOGRnNXNYVlh4MTB4V3dHMlNZMGdkakVXM3FhNGMvTlo5RjFG?=
 =?gb2312?B?UmIxcUVpR1c3Q0lPMjZWSlRadWdBS3FEWURoSTNZdkp6M2srS1djbFdQRGlY?=
 =?gb2312?B?TFR1WmhJK2xabGEweGp6Um50Y3o2ZlprT1FWc2NQZXMxUVRDaUFYNVVGVGk2?=
 =?gb2312?B?d2NiNVhzNWpTNURLbUVnL1F3bVkrajRSaHh0eFNmYzJyUWRLWDJjMHhxeXRw?=
 =?gb2312?B?SDBWbCtCUUFWVjMrdTAxaFhYeGx5U2pjT1J5ZHEzbzdodjBUL2diZjJUTDYz?=
 =?gb2312?B?WnhRWi9rVnZ4WFlqV1EyTERncE41TWljYjBuaExSczRVV2JyL2JuTWdwQk5M?=
 =?gb2312?B?S0srQUNvenhiMWF4bVNVU0l5V3k4VnEvV3g5Z2tPQ1J4MExEb1N5cmlSR2Vz?=
 =?gb2312?B?d3VURzJtOHdRQnc4ejlaMmhoaG1DUmYrQkoxTk5SdTlnZ3VzRWhTSFlxQlpF?=
 =?gb2312?B?QlVUQUdaVVdScnZKRVJNRjdGZ2JoRWtLSWhuK2cxcjh6QWtoZ0UzN1ZXeDd0?=
 =?gb2312?B?Vkt0SDFoVWpYeWdTT25GcXc2b1pxS0luZlMxV3ZxRmlFUlM3eUdVZ3lFTXM3?=
 =?gb2312?B?WXowNzRRMVFybzMvQVdScVBST1ZNNUlZTy9mSnRWTTZZOEJrZVpUUkRYWVJv?=
 =?gb2312?B?SEo4R0lFYnAvV1dYWjVPdmtnbGxiRzdTejBtZ2lQTEc2cTZYT1NHd01NR2sr?=
 =?gb2312?B?SCt0bmwxUnIvVjZ5Nm5hdU5pdytuTnFIcmVZRHBjQWp4bmlsaEdMMmFFcFFx?=
 =?gb2312?B?ZDFOc2RRclprQ2Z5TkxDWnU3ZjdlRHBPaEJpSnYraTJMTlhkR3VwNVdMelhR?=
 =?gb2312?B?a3RDTkJMNFpBeDc1by9RRTVhenA3NE9GdzdVeUd5RlE4MGVGdldYRzdTK1pD?=
 =?gb2312?B?UUJNQ0RkcmZ3QXlpcGZJNDNDQlFtcXRpSUVnM1hrYzdCZDlvemgrVDltNE9a?=
 =?gb2312?B?MUoyalBBNmM4dEhUZHNWakdWTStuTGJ5WmVYZlo4bjhWaXlGdGFQKzNGRDBx?=
 =?gb2312?B?R2xHalNzc0hFZmNwZ0NwSlZ3WHpXQzYwc0NDZEh6L29walczWElsR1RiQmpE?=
 =?gb2312?B?T3hncEFZblhXTUN1dTQxNU8wTGZ4a0lQbjc1N002UDZCWTM4Z1FORHhZZmlt?=
 =?gb2312?B?T0Y5ZDUxQ1pDdXJ2SVoweVhwRjZKajhvN0UxWVl6dnVFMUlKR3BuSVpHZjcz?=
 =?gb2312?B?TEh6SUJjZUJKdHhnZks4cmJqNlptVDlJRGp0amFkb0dySnRKUGN5WDVGa2R4?=
 =?gb2312?Q?t7cLhqKgNBd1D53NlOZK/tNiZ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7d3026-e001-4092-786a-08de070ce317
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 08:21:46.3850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFy43eyCU6AhFV619cFV/SUEY6Vo5Gs8WM1BKqU5UWADkhbMs8r+SMXU9IQrljwDBnxRwBT+So9bCuyfrpJFSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

PiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAy
MDI1xOoxMNTCOcjVIDE2OjE4DQo+IA0KPiBEb25nIEFpc2hlbmcncyBvbGQgRnJlZXNjYWxlIGVt
YWlsIGlzIG5vdCB2YWxpZCBhbnltb3JlIGFuZCBib3VuY2VzLCByZXBsYWNlDQo+IGl0IGJ5IHRo
ZSBuZXcgTlhQIG9uZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMgS2xlaW5lLUJ1ZGRlIDxt
a2xAcGVuZ3V0cm9uaXguZGU+DQoNClRoZSBjaGFuZ2UgaXMgb2sgdG8gbWUuDQpSZXZpZXdlZC1i
eTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KVGhhbmtzDQpSZWdhcmRz
DQpBaXNoZW5nDQo=

