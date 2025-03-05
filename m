Return-Path: <linux-can+bounces-2980-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95DA5006F
	for <lists+linux-can@lfdr.de>; Wed,  5 Mar 2025 14:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BED2163A30
	for <lists+linux-can@lfdr.de>; Wed,  5 Mar 2025 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F7248176;
	Wed,  5 Mar 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="nD71QJK2"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011023.outbound.protection.outlook.com [40.107.74.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C401EDA0E;
	Wed,  5 Mar 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180763; cv=fail; b=g/Gfd0J0dvSPCPHO1YhWjB41he3MmF4fKJkDYY/ALQsQFPBFh3zIZgV+C4DgQ2zQ38V4F6cax93xWyoV6Rq7EytmU8ToP6cs81a1R9FzY3OHWbeVbvpabW0U22NTG4OyZX28QSDoM+ten+mBvAeBznlsjgTKBx2GlBT5iaHo6PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180763; c=relaxed/simple;
	bh=CxZ6kCJRQSdMIwwfVd21w2vH5AJ01xYT0Rg9wJ3C4EM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ndhq5iaWsafg358lb7n4rIxz19E4o4Q/UlwuVdqu0Py/Ox0pu+411ndWWKqYaQ6mh5b+pj4UoDKZpTx+tL3/EL9XATFJXhN/EplHZbOv3A0fd/F6Vr+jH/6ReTxr3yxw3KM4S90bBS9Zzg1n6pK8sRXrc1bjNaxpdVWwprxocp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=nD71QJK2; arc=fail smtp.client-ip=40.107.74.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeENz7MMPotAlO+W8i+T2N6EtpXb5C8f3yYCISTZWeXfoj7cZTohTmklWDd7oKcO9i64z8ABfliQer6pJ2qOgJ6d4imMqPk/20dAhpfrhwQ9CgAZb2iYP2lJjPKM+u+83uBTNvfuSKUoBUlZzQlwUbVdTp4X1CDa83YixFxcz6adBASGRBO6BCSlos93gk2BLzs2tMRjivWYjvFdMz6pyFGJDM9rIzQCXDy1TDdigviPsAjbaM9RnXiAYt4knoPmiubybWvSafeWj9zmfK/q0vpCOEklThqqNi+eEaGplHL6mL0bODLryEi9GvAJWtMA0hG/8rCTR3z8Kli3p/i3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxZ6kCJRQSdMIwwfVd21w2vH5AJ01xYT0Rg9wJ3C4EM=;
 b=xiQHpUgKc65gYYNAaYrqqLFa3OXU98zP+klbmKfXXFR6rOBR6f7cbA4AvWIzuqDsm152ndshmGXZerehseC9c8UFNZk4JN/DB2wyNejez7CL2Q3pKimEZnQVzkmsl5dveKP03U2BiPmNITS3u8nNtyH3CkClqkLNd1YxqhdiNJMV3147OBK2/FQjc/tIr8OVfxa5BI0SZPJTpDX4ZPTNLx1nSonu+xvuCDNkMvLgL3JcCMEYNGjDVLoxF+xi+WcuBkMPpiHCeglAc1HQ0i7Irls2xxmiuXXSDFSLU3TehizdUxHgog280MqHo0phIJEmmGw6wyzWUQ83+ZmZGdJB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxZ6kCJRQSdMIwwfVd21w2vH5AJ01xYT0Rg9wJ3C4EM=;
 b=nD71QJK2im4z0eLeJGmW5/oqtWJyINOJtgJQkf9fPunMiB7ELapUUjVAQCgxeQAIHIbtsUBSiFmQBfv6Tc7Dx3ykR63K1+uix7QwVojT71Ls19fWUDxm2ov1VjYS3BNkLvPBUaWWptMPR9WBooCXGPB0qcv7Jhr6qxXTHeG7BpE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9829.jpnprd01.prod.outlook.com (2603:1096:400:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:19:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:19:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 06/11] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v3 06/11] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
Thread-Index: AQHbh5u/d0m2GEUyUkOt6vJcVGfCj7NYKjaAgAxot7A=
Date: Wed, 5 Mar 2025 13:19:09 +0000
Message-ID:
 <TY3PR01MB11346CD1A2FE37535CECD912C86CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250225154058.59116-1-biju.das.jz@bp.renesas.com>
 <20250225154058.59116-7-biju.das.jz@bp.renesas.com>
 <20250225-urban-devious-worm-f1e178-mkl@pengutronix.de>
In-Reply-To: <20250225-urban-devious-worm-f1e178-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9829:EE_
x-ms-office365-filtering-correlation-id: 1dcd655d-ca08-439b-e814-08dd5be8504a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVVEcnZYRStVTTNOSkIxbCtiVU9vWXlsb1ZiK05McmsvYTVqQlVjVnBYZVlZ?=
 =?utf-8?B?MWs5aU9wQ3RMNkRDS1NDeUdMcUJuVkQyUks1Tm1NUE5VMmZubUE3bTZWSjh3?=
 =?utf-8?B?R0dqN3pYWGdZT0QxMHowbWJxRjZucDJqZzAzUVQ4LzU3N1hNNjlvY1FsV1hO?=
 =?utf-8?B?MzA2UHJNV2VNWUJLQitsZzJMeGt2REFrNUR6NWQyZ3FyeXZ6TVQwZ1VLMVp0?=
 =?utf-8?B?cVhrajFGSElEaVlqdHhJQU02c2tNbDBoMEY3eTFvRDBRM20wbHgrcEU5aVZl?=
 =?utf-8?B?RldFWjJPaDE4VUJobHpweWZSVGFGajVGK3B4Y0ZZWUNTckJrQ04yZ2NCbk9W?=
 =?utf-8?B?bENUOFFNVlFkUnR3YXR0WEJVd3M0R08vd2krQjRscDdldDdKQkJLZUcrMURk?=
 =?utf-8?B?NnhGMzJDU0N4cEpQR0xBamNsQjB2eTcrMWRiMkh4N3RXU2pYRkF6dWlDNGkr?=
 =?utf-8?B?RzF1VUwxaG8razB6ZTZFZ25lL0hodEcxem5pYlErQXRxWFlIS04vbFdaRm9s?=
 =?utf-8?B?Wk9ORmJTNElTUTRIWkd0d0ZpMEJNeE1HekN1S09MMlcybFJ0UW1oYXd4TGxh?=
 =?utf-8?B?OCtVY2FobzBWODRhbVo4TG84ekZsU3Z5b2lidU5uUkRKZE4ycGpnbzdyeTBR?=
 =?utf-8?B?ZUg0WFVYYWdNWUZHUFRGYllBdzV2d3YrRnIxMVRadjF4VVNTb1gvTUdJalpL?=
 =?utf-8?B?a1J2THJkUlpONjR1MnJDWDMyRDkrNHUwQmVRVWdQcjd5UDlBMXNXT2RGV2Fu?=
 =?utf-8?B?NGRQQ01XbjdmaEl3MDZDa0JpSjY3NXp1cnJYcVJtTHlmK0MvOEEvYkwyY0lG?=
 =?utf-8?B?bTIzc3Q0disrMzZhRG05UDl6Rm5lWnRyeER2NEl4NmppajEyUmFndjkvZVJs?=
 =?utf-8?B?OExUaVJ0UUZ4OHA0TC9jR253cEJ5cUZxYXE3WHpxZXEvdUR2MDhuZm53QjlO?=
 =?utf-8?B?NGN4MHZkWGVNeE9FMUtMbVcwUUlxWklLSmZVNk5MeVpsUnhmbUl3cVpSZ3pC?=
 =?utf-8?B?N3RXRXQ0cGQrdjdnUjdWcHFvNWp4NkJ3WXIxakV2aVFoeW5tZkZvQWpvNXlv?=
 =?utf-8?B?bGNBQUh1dis1ekpTdmxNWnlMcktTd1o3R0FBaXgyeHNaT2VuMGxNdEZMR3lC?=
 =?utf-8?B?R0JlRmI4bUVHcmRuVUV3OS9jOEtORmlTa1NDNWIydGxWTU52TEdLZXd0a3pX?=
 =?utf-8?B?alVvbGZ3d3Bjb3FYcjB2SGtsM0MzaEErTVgxWTlodHBRMndNeE5rajdGRkNN?=
 =?utf-8?B?QVluaEhLYzhRSGFMZUFQeWFqQ2ZUcEdyODd5dktqNGtGbExYbDRWeUV6RFIx?=
 =?utf-8?B?aVlRRC8rRTBHeisyM2syQ1JPYlZtOEJ1UDViY2Z0ZGliUE51YmtOdndMTHpx?=
 =?utf-8?B?a2tWSjM0WmJlY05rUFFyTndqT09sYTMvckc4WG0vdjJ0Wk9OS3JSWHhSdnRT?=
 =?utf-8?B?OW9CUGh0NWJCbzlMSC94elVLZmg0NTNSWEh4SHI5U0tJczNrOTdGTXUwaXJr?=
 =?utf-8?B?WEpwdEIvZ1hPeE0vaHVrWllNMGRyWlpiM2cxS2E0WkRiWkpObEl3QzFya1hp?=
 =?utf-8?B?dUZjMmlJRG4xMkNrOU9wYlk4Tml5NVVwOVhPV1JpaGVCT0NQZlFjc0FXNUo0?=
 =?utf-8?B?eHRHNm1COW9nRTdqWUpDNUVLSWdYcnFCVUVOSHJHMjlpTlFIc083OXd5TTh0?=
 =?utf-8?B?L05Fem5kcWxtMnAycUQ2bHJCK0RDUXhZVzJTVnNPdFlhQm9WNVQzMWdDNFEx?=
 =?utf-8?B?TE5JQWQrL2NMc0ZZL2FUNHJwc3YyYndiSjhER0RmSFFXYkt4RWFla2VIeEYy?=
 =?utf-8?B?N0lDNzN4T3VQcU1LYjd0RkIvMW9ENzRVSVBNT3plaFNKTGc4Wmh1bW5YVlZr?=
 =?utf-8?B?RTVLZmNXcDMveEdnb1NTeWJVaVhKaTBuRW1KMEVPaXRZVVZwenRxU0g2MlYz?=
 =?utf-8?Q?sCoa1nFi+PEWySTG3NPNXokcVjP0k+5b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXVqK0FOYVhTYmdtUlQwTVZWeGRhOTIzcVcvdGhlK21PZUYyMGt2M1RJUkY4?=
 =?utf-8?B?V1NYelFWTnpVWHVCcld6ZkhjWE40dVRHMW82USsxemRVa0w5OC92b2FMSDBR?=
 =?utf-8?B?WkhZS2h4aTBuOXU1eFQ2R2JwQWF4ZlQ3VWxaUW5ReHJqcHh1cSt0VFQvRFAr?=
 =?utf-8?B?TkEvTWM2cW1BVjlmVVh0NDNyNFlxTXBuc2ZQMnhDS3JwWHgwNE0zcFQxc2tP?=
 =?utf-8?B?b1p2aVJKUnc3amJJb0Q0d25YT1g0b0ZnMHFZVDBYSjZlYkVqWFJBNVdlclFC?=
 =?utf-8?B?cVRrU0ZXR2Q0bXR1SkVXNVRCK0tJaDJhdTFVTmJjWHp0dzl5L1dONHFRVnJB?=
 =?utf-8?B?OVA0eHE3VnA0RExDU1F3U2ZVb05KUGRxV04rTlkyR0w1NzNIR1lYWjVBc1N4?=
 =?utf-8?B?Y0gzUnllaDlUY1JSTTc4bmhqNW42UVU2d3FUR1h6U0ptaE1HUFJrK21td1U2?=
 =?utf-8?B?SjJocFprMzZMU2NmTnowWmxUVWZpZUFPUXZlUmNqMThMeFF5RWlzdXBKYkVB?=
 =?utf-8?B?ZXZUY0JGakREeTBhTTVHa1d0emZQN1lGeHg1ZCt3TUJKREIvaUZnTmg3Z0Nj?=
 =?utf-8?B?SHFtQkgwY2lJalJkbmNnOXptalQ4dWNjUWFtZ0tVbTdmMzc0RG10TEVZYito?=
 =?utf-8?B?OGkvLy9idUM0Vm1vTG1XUzVyUktrd0ltSlVSdHJEV2l2cy90dmNXTFNjMlhk?=
 =?utf-8?B?NzZZOXEzeVhBbE1BKzczbk5FQThXZGVzS3VjQkRObWF1YUlSTkhOcmJ3eURv?=
 =?utf-8?B?OCtFaW8wbDgwRDNzQXJvZmIzcHlIZDBiTnUzdDQ1M2hzaStzdzFxQVNaUFNp?=
 =?utf-8?B?S2NCTVFuY2dCc3daM3pBMThqcFQ1N2VSVTFvU21UVStlb3ZJakNFSXkwamxZ?=
 =?utf-8?B?blIrVjNLaDRvcFdYaUxmSHp3YXQyUEpyTHl2K1ZEdXo4Q2dZcFNieDRpQ1Qy?=
 =?utf-8?B?RmxXMzJ6TFl2THY1enEydkdkWWNqNjl0bGJvRm96VCs0UUdaRDRyalpWNzVU?=
 =?utf-8?B?c2RCM1ZCNU0ybXpwSW1Na0VtQTh4SnJLdVVzVm8yNm10bHN1UCsrSisxQnlR?=
 =?utf-8?B?SmpHRGFZcFBjdGlIdUpZRlovNzd5NGxja3UrNHlNU0p1UUdVOGNGU01TdHBr?=
 =?utf-8?B?WDlEUHBNd2ROR1pnZTZmSThqRUxtWExpd2NHeG9rRGFRUnM2MTFFWHY4MTU2?=
 =?utf-8?B?czNmUDd0Z25CNjdwUzlJU24xVmFRckJ3RXdvbFJMOXoyT3FKbEl2elVCM3Vt?=
 =?utf-8?B?bmZGT3BYcTlaaWFWWDVVQlI4Zkl5dHpNTFc4SkhyTC85OHY0LzVCcXgxOW9v?=
 =?utf-8?B?VndpNEtCT1lQV0dqVkRnaWJYTTRad3Y1cjB4V3lmakduQjR0NmFuSlN4NmZO?=
 =?utf-8?B?a3hmeVFYcUNlai9BWE9VSzJYMENNamllQUNHR1F0K0srWDZuOXU0WFI5dmlp?=
 =?utf-8?B?VGJoZjFpUE9QYktwN2d3aTdSUk5kMnRuYTRzRDc0YmtJa0R0V0VZRWc3VTZ4?=
 =?utf-8?B?NlF5NmtZZEExTmhoM1pkQ3BwQlVBK2Naa3gvOWhwM211cS85UWlJeE1kQnlV?=
 =?utf-8?B?WkxMM3NKc0tPUGZiakNRVm1OeHNEdVl1YjZYWGFHM0YxaXZneWh5Vk83R09w?=
 =?utf-8?B?ZFNkeWdEWFNnbE9uVWdPb2tUNTBTK25aeUdUWG9DbXBwZDNMR0xpSk1GUDEr?=
 =?utf-8?B?aXA1eDZUaVB6UERLOXFYV0tnRCs1Rk83RzI2VVZpOG02YlhPeWV5WWw2REx0?=
 =?utf-8?B?bE8xYk9xZ2xmaUovWnV3YWhxWjg1bmlNUVh3TFNZSU44VnFIK08vcjhFdGR4?=
 =?utf-8?B?VGs1REFYM0phMyttTHYzdzVtZU5yMTBuNE54eFhlamdPdjUzckwycGNXR2tD?=
 =?utf-8?B?aW95WjVTVnpyTEppL3MvVUdTRG9NRzV6TElWYk9qeVpRTHExRk5YSnh3bmRG?=
 =?utf-8?B?ZjJYdWp0bTZHTjhodVZZeC9aaU90M0IxNHUzakM3MTFUaXBEQUYwbUJoMTZw?=
 =?utf-8?B?OTlRTFcweGQxZklsTVIwOU1lalBtMW1JTzhyaWlxSTllTUtHdE5wK2ZsWDd0?=
 =?utf-8?B?RHFGQ3V3UXp5dXVIb3orYm03YWZnalpzblZLWlJjTC84TllybDNEOGpNRURv?=
 =?utf-8?B?VDliSUd1MTVXNjltT3VVdUlYT3VMRDF4cm9qL3lrNE56aEdXbkpQRHZKTHBJ?=
 =?utf-8?B?T2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcd655d-ca08-439b-e814-08dd5be8504a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 13:19:09.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wjq8UKMNq/Abnswb+uZY2Q36BtYNJCMoLYGAO12/wuctc2nFOUdLooKR/KCZ+hDvW0kN+k30fqm+Tx2NObsvqEfTyXYAq4nlYFFWCdvHOkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9829

SGkgTWFyYywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5k
ZT4NCj4gU2VudDogMjUgRmVicnVhcnkgMjAyNSAxNTo0OA0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDA2LzExXSBjYW46IHJjYXJfY2FuZmQ6IEFkZCByZWdpc3RlciBtYXBwaW5nIHRhYmxlIHRv
IHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IE9uIDI1LjAyLjIwMjUgMTU6NDA6NDUs
IEJpanUgRGFzIHdyb3RlOg0KPiA+IFItQ2FyIEdlbjMgYW5kIEdlbjQgaGFzIHNvbWUgZGlmZmVy
ZW5jZXMgaW4gdGhlIHJlZ2lzdGVyIG9mZnNldHMuIEFkZA0KPiA+IGEgbWFwcGluZyB0YWJsZSB0
byBoYW5kbGUgdGhlc2UgZGlmZmVyZW5jZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gdjM6DQo+ID4g
ICogTmV3IHBhdGNoLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2Nh
bmZkLmMgfCA0OA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gYi9kcml2
ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiBpbmRleCBmNzE3MjVkYTU3Y2UuLjI2
OGI5Yjg4MzVjNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2Nh
bmZkLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gDQo+
IFsuLi5dDQo+IA0KPiA+ICtlbnVtIHJjYXJfY2FuZmRfcmVnX29mZnNldF9pZCB7DQo+ID4gKwlS
RkNDLAkJLyogUlggRklGTyBDb25maWd1cmF0aW9uL0NvbnRyb2wgUmVnaXN0ZXIgKi8NCj4gPiAr
CUNGQ0MsCQkvKiBDb21tb24gRklGTyBDb25maWd1cmF0aW9uL0NvbnRyb2wgUmVnaXN0ZXIgKi8N
Cj4gPiArCUNGU1RTLAkJLyogQ29tbW9uIEZJRk8gU3RhdHVzIFJlZ2lzdGVyICovDQo+ID4gKwlD
RlBDVFIsCQkvKiBDb21tb24gRklGTyBQb2ludGVyIENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4gPiAr
CUZfRENGRywJCS8qIEdsb2JhbCBGRCBDb25maWd1cmF0aW9uIFJlZ2lzdGVyICovDQo+ID4gKwlS
Rk9GRlNFVCwJLyogUmVjZWl2ZSBGSUZPIGJ1ZmZlciBhY2Nlc3MgSUQgcmVnaXN0ZXIgKi8NCj4g
PiArCUNGT0ZGU0VULAkvKiBUcmFuc21pdC9yZWNlaXZlIEZJRk8gYnVmZmVyIGFjY2VzcyBJRCBy
ZWdpc3RlciAqLw0KPiA+ICt9Ow0KPiANCj4gUGxlYXNlIGFkZCBhIGNvbW1vbiBwcmVmaXggdG8g
dGhlIGVudW1zLCBpLmUuIFJDQU5GRA0KDQpPSywgd2lsbCBmaXggdGhpcyBpbiBuZXh0IHZlcnNp
b24uDQoNCkNoZWVycywNCkJpanUNCg==

