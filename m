Return-Path: <linux-can+bounces-5442-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6AC61287
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 11:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1E9F4E21A5
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29F23717F;
	Sun, 16 Nov 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kW9UzZ6y"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010009.outbound.protection.outlook.com [52.101.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27D21507F;
	Sun, 16 Nov 2025 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763289090; cv=fail; b=QcMtHss+lNXhbvDrDQEdJIC4NehU2mYOcy9c2EU30RsPrNlrtwEcsgM98z5vGFJ05O+jbW11M5zomntIlqnZEX8afRM48hBHudYINXcSgVv4OGKH7EsORuvG6WUNliyyN9j1SG8SKTc9cBtDshmIve8dQ8fGQ5/cnyJDPmD6pPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763289090; c=relaxed/simple;
	bh=EsoACv/H28BBYhdiGfDdTjCFRdqegXihrLBchKCNOSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DmumnT3slED8or3g3C2dVBifdKezlWtKTmaIl97fXIP2bp9Vrs8J+nYGDA93oraJn9EugoPR4A/Ay927v8RjLOCBP+wzYuHyimZwM1a/CEgdsDOwS6xmc6E/0BFQKpGlJnQsEQW6JvBqpXzfnayn7HEY/SbPeET8/1J5viGjjzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kW9UzZ6y; arc=fail smtp.client-ip=52.101.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlwGmjE7bpq7BvJcOgG4uuXnuvwOm7WYqJf+rZEN2XJxDgBPuDJy5haJN3NJfO+bpGgD6X/FBSah1L5CJZbCD849oqFV7ChQzYi7MHYvu0EjxV+SDO5bRYhm4kVudeBBroxsKxFgKi045sVipZ9JYZrMkFjpLDZanVHEJRdTjq1KyICtEwCsxt1o26YHu1dhxgO5Ww9aLD0paJMvYSAp5RT1ATJfmQBPRRPHW2lvRHSZv2xD5cD987J8VQ60h1V3n2P/oa62dYo/nzP3PpJl4aFv+p7WXW/TML8KeEmoQrHjGbi0VXv5fL3MAs9zA1PXWwTn/FyYIhZqLLjmHWRO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsoACv/H28BBYhdiGfDdTjCFRdqegXihrLBchKCNOSM=;
 b=XctrWVeOZmiBUj/0g53KnW3zQK19hcC4nF2W8/R3bgSTPjWaqTDsMSQm0dEjhH8eAzs6LnoldCoMlkKMIGV1PFDwhdym4CtvKrIbLKXcFuED4ysFfEOcAalHSrw0OCRH1WZUs7bmqVHSGkblXX3FsI4aLlw7I9yLbgaRx83FiblK3JrQi7Sc4e1H9/GxK0AwBYPxGGYVCw9nI50kDu11VYs7V1rrBGuy0VjWTFy7b4a9n5ZRGMUj14c+Wi+cXP/lw+QxanXF9c9OgkcS71sPpCyAXAJ1FcnzdpmICAdVATPnVW911MJiiU3mNnsOEFqPSznhp95R5z4kd8abXgDt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsoACv/H28BBYhdiGfDdTjCFRdqegXihrLBchKCNOSM=;
 b=kW9UzZ6ynk4yHzr1tH7diJTAZGby4rezvvYYrSqi92hFru74CGNovrp56ugFeTnk/yAdtSma/ncrfWHe3dPup6pFcYlIwfMxzLdGojZqwpooW74gZ/qp4T85ohJY5PevLymyYZfUIYTPhUfh8fZFyNO7W/E2gBeJ55oHiky0Aw0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14605.jpnprd01.prod.outlook.com (2603:1096:405:244::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.8; Sun, 16 Nov
 2025 10:31:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9343.008; Sun, 16 Nov 2025
 10:31:14 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>
CC: Vincent Mailhol <mailhol@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>, Tranh Ha
	<tranh.ha.xb@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L
 SoCs
Thread-Topic: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L
 SoCs
Thread-Index: AQHcSZVzMv+xB+/yKU6ldKbXUm40nLTuzr2AgAUCCvCAAWEmAA==
Date: Sun, 16 Nov 2025 10:31:14 +0000
Message-ID:
 <TY3PR01MB1134632B48784F5D72721611D86C8A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
 <20251112-warping-ninja-jaybird-22edde-mkl@pengutronix.de>
 <TY3PR01MB11346974232A057A7D5B6EBAD86CBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346974232A057A7D5B6EBAD86CBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14605:EE_
x-ms-office365-filtering-correlation-id: 2431c9ed-5aef-45c3-487e-08de24fb4503
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFJiQ3Y2U3orT1I0cDBhMlU5ZFBpcS9NTmcrbFRSQlNKSm1JMTcrRFU4WDdX?=
 =?utf-8?B?VEZ4cE5rQVN2OWx1dkdEUEozbVA1Smtza2NrNFY3Y1RaMEtDKzFpbUpRTHlq?=
 =?utf-8?B?ZFh1ZmlOTVpsWWxpRERMR3pwbHEyTTZtd0lMNXhKb3JRbGJDVnVERUJMeXpS?=
 =?utf-8?B?Tm1HZzlCd3ZCaEYvTkJHMmZTYkx3VmFiREdVb3JNdHRmU2F0cjhSZFZ1U1J4?=
 =?utf-8?B?Tmh4QXB3RldUK05qZUsyR0htSUQ5WkZPNFBhWmxUSk5zNDRLSDRXcnpqSkJq?=
 =?utf-8?B?MEZtR1dGQWN5c3lER3VyVWdrUWxzMUprR2dhWnp0L3BuUGQ3UjRzMWhoK1Fn?=
 =?utf-8?B?bktMeXZCWkluYmZlWmdUUXdqSlNKcnBqSmhMNUdTM0lUSCtNWkRFenp2NkFx?=
 =?utf-8?B?cW9HazE4dHNKN1RJU1ViZEZvWlVXTk81UE1XL01jQzQ2OHZDTmUwOFhOUlM5?=
 =?utf-8?B?STMwNnlDd2lLNVl3bzBvTEU5STV6c0ZZWENoMEZic21EQjJLNFZNSjFDZi9N?=
 =?utf-8?B?NVVHcTZxVTBRUHc4c2hmUk9FMXlwZC9OM05rZVN4RnM5SnJvNWZQWlBEQU9y?=
 =?utf-8?B?OEREMFA2Z29XNG1JNUtJQVI0UzhReVZsSzVPNnhua2NvdjcybEd4Vk1sNmdp?=
 =?utf-8?B?N293QnYweWQxbkkvOUg4S09jalpsazVPZWlLd3lTb3BEeDNBbDh6UnY2QXhx?=
 =?utf-8?B?eDNWR0dsL2hzWEx0Z2lWNzk1UU5OVVpqM2xEMXBMUXFUdUJtbGhtUEFGemQy?=
 =?utf-8?B?U2FjVFJxL0Y2WTdzanNwNmpIZXZMcTc5bWNmNS9WRzJ6K2J1cjduRW96WVRw?=
 =?utf-8?B?SllFVEtFME92L3lYK21qOEZuZVlFYWZDQzNHTzI1MzZ0a3dROW4rMXRDM0VM?=
 =?utf-8?B?OFhDU1ArclRKWklubXQrMXdlaVozTmtmRXVUMG9XYzhIYVR5eXJoNGp4bU5B?=
 =?utf-8?B?aHJXRHVKZ2ZxSEFKQ0xDVVJQRzBuVHN1STRZNWtBUUkrdmxYUEZLeGQ4S29H?=
 =?utf-8?B?Mjl4ZkdiQUxqQ1EwVWRIZlBvNEZhcFk2bjhiOU5HVHhJbFRHYnlSNVFtZDlE?=
 =?utf-8?B?d25lckU2bWh3TkFSZjMyYWV0MVNaVklJemFib05xYjVidjlVN0ErbHIwbW54?=
 =?utf-8?B?VnQ2UllpOUNISnBscGRnYllOckwrSC9vVjlvdUFWZ1E1UXZldDhSUWlVeXd6?=
 =?utf-8?B?dnFiNFd2OHBkc1BSRjdvVEZKVTZiZzFpR3M1RythaS83eVBlV0ptRWU1RnRM?=
 =?utf-8?B?ZnoycER0QS9RWXdTTmFiTUhYY0xzS0s2aVJKcHhybnNxeUN4Z3VjNkx4RUlR?=
 =?utf-8?B?anIwbmQwN1htNTVhT25wVmpCQzdKUEtucHo2NDZxRldYZklDeXF3dDhES0V2?=
 =?utf-8?B?cURCOHdJQ0VScEtmREhiSTRDbUZsYkFyTW84djdya3FEdGxrRG1vZEc0OVBR?=
 =?utf-8?B?U0ZRU0puN3I4clNIbHdReEZvc0YrVUtFUS9sU05WK2lPMEFIS0NvOGUrVTlV?=
 =?utf-8?B?N0hoL3U4UXZvZkhDTTh6cmxtb1VuL1J6ZFQxOUxwR0lwTVZ5YWlVSlZYZHZp?=
 =?utf-8?B?UnY4R0tyT0FrbDYxMkVWWlUzL0dMYjh1Q2hCNmJmUGlzbGVJU29rQkR2QWVV?=
 =?utf-8?B?dWhRdjA5cGNVUU5TWDY2eU02b0pBWVBaN0JyTnMrbzczd0Z3VXJtYzI3TkJo?=
 =?utf-8?B?b2EzaGFxRUtkSGw2RmlnVWNJWUs0d3JNajgxNDQzNURIM3dQeUljTXhWVVlV?=
 =?utf-8?B?aWVXNWw2SlNmM1dLMXlTYjJ3Q2c0aW1Wbk5nekVNSmkwUC9QOHBjSU1GZmRW?=
 =?utf-8?B?SHgvVG10bEFxckp3UUJEYnRKVUpoUXJjbThvQlJxeC9BRlZJQnBLMGJ6NmxG?=
 =?utf-8?B?aXdpSTFwQkhRRkJDaTk2YWxjendSTFhKN21tVlZKSHBXemVueFhobjNtV1A3?=
 =?utf-8?B?b0MvZnA0ajVzbThxSTFBa2tWbW1DUHJHdjIxQ3FGMjF4N25nK0tIK0czbTVE?=
 =?utf-8?B?TnZpMGRhVFR2dXNFb3dhdGlid09kaXc2WlVXYWlmdHY3N2w0U2JNY0RnNU94?=
 =?utf-8?Q?HV3fTL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFJjVVJDVHoxbmFrdnJ4SCtMWDdxQmdlemkxZGRadytITVUza1ZKQXhueWtW?=
 =?utf-8?B?UUdOQ054NWtnVkR4bXpnUEdnelBzWXdjdTdwclZoWEdqOWQxK29kY24za005?=
 =?utf-8?B?azdqdnVQVGNTRzBESDM1WVdLdDZaM2s5dTBGdlc1SUFRODh6cE1BRkZsM0hj?=
 =?utf-8?B?RFR5UFhLMzdWb0ozcmwxRitieXFIV1AwRDBiUmtkUjF4alJiTm52eGlpNXBi?=
 =?utf-8?B?VFRDSmlOU1hRUXZFcm9WM1lucWJ2T2lOREVCUVd3OER6Q05LYWRydERENmVO?=
 =?utf-8?B?WU8wMHY2RXR2OXg5WVJMSHEzZXhWU1NnSUZKY3BzZmNBcUN0NTFpeWtKUTV1?=
 =?utf-8?B?ZmNSZDZzd2daWWNKQXJQT2pWaFlzaUllVHU1TmhHbW9seUVrZU9SemI4VjBv?=
 =?utf-8?B?VFFFOEdWUlo1YlNZSVJnZHZwMVN6QldrQkJFTnE2NWtSVE51YUJsZjhFbm1u?=
 =?utf-8?B?UTFZdXM5STYxRjMrRGxzNjNUNFRMR1VVOWViaWsyR3hDZWNrWFQveDRCSU84?=
 =?utf-8?B?Ym11NmxSQjFub2w0ZWFTRVJ4SG9Fc1Y1eENjeU1KS2N1bUZsOHpEQVR6eGFy?=
 =?utf-8?B?dWlqalAyL0lHNU1URlZKcFArTm1XZlF1dDZ0ZUpmOWFYOWhzY1VqeFZLQW9O?=
 =?utf-8?B?SDZqcFIrbFpjdmhCWm44bEVUeHJlUXNiaDk5ZkpHVG9IM29RNmxMYUlnUENC?=
 =?utf-8?B?TDR6MEFRYTgvOHg5NGV1Mkx1dU16dXlXN3RUcHZSc0RrS1NoRTBGSkRabkFl?=
 =?utf-8?B?bGlkby9DeWVoYmdqWUxUcEluSGhOVUtyN0s4Zi9NcVN1YTZFL2xhbFdtZ2RD?=
 =?utf-8?B?YnE4dWlpbmduWjhqZGE1TDhBNkF1QUl4NE5VenFrdmxxK2RWcG5xVWdaMFdw?=
 =?utf-8?B?RGNRWDQ5NjZDdWxpeDdBbTlGZGw4RSt4S3BtNkdsYnQwb0ZqSmpucTE4TXp4?=
 =?utf-8?B?YUREZGo3cHRGYktmVGpockNGS0xFTTJsSklwWGMzVEFlVnJJY3NvdmtRc0Za?=
 =?utf-8?B?bmF6U0drdlpUVGIzdTA3VmcrRFVMYWxUNXdUWjFNRCt5MUoxL1RRR2Q1UEQ4?=
 =?utf-8?B?TjBlalZVQURXb3ZkVXlPM1NVYlg0T1MzOGJUZm9LRStaTVJMV1pmenJCZWp1?=
 =?utf-8?B?eHdjdjRKS1JCaFBhT0JHZnF2TlRGMFduNnFnWW90OVhnNTVFbzRGTmdjOVYv?=
 =?utf-8?B?Y212dHR5TnJjREY1TWJHelhCNVp6RDZ1MlFJTDJkMjNia2dOcktLMUxvM2hR?=
 =?utf-8?B?UGpTOTh4dnBVVzZabVlUcUpVSzhJNkdZam5NM2JaUGJ5dFpMMWlWS1lnaDBl?=
 =?utf-8?B?WTB6OU43ZTZ1aVdPcXJCclJxTlo2cHQyWGdPZFBqYTdUV1FuKytjcDlJcitZ?=
 =?utf-8?B?bDU0d05vTFdoNW5CdVRIRnRsZVJwWjRzVkFLOEdIUWp1c1NZbm0zNXoyWjVs?=
 =?utf-8?B?cTJ0TG9ScnFQRGxORWVRNVVMenU3UXZwU3gyV3BrQ0N4OFAxMHcxVjREbXl2?=
 =?utf-8?B?a1FtQkhFN2pMRXhvYTMxZm85cmpJeWdnMmpsK3VPTzRVMkFtRk93V01FbHhq?=
 =?utf-8?B?UHdTNHgyVnc4eDJvdVk3cFBoam5sRXh6YUpBMUVFMzlSNDVDbGtJLzJyVXFS?=
 =?utf-8?B?b0JUcVlPL1NQdlM3Z09ObmZJcTA4a3p2cXVyYy8ySENaai8wVC9FV0crcEJ2?=
 =?utf-8?B?OUJyWnVFV3NaYWRjb0dteG5la2F1dmVPY2Zsd2g2Zko5SkxiTTlxTG5xZEoy?=
 =?utf-8?B?QlFubU9RZ3hkQjZyNFg2THJ1amhaSjh2OE81cTRQV3kxWWhGMWF3d3lLdmxV?=
 =?utf-8?B?Q3BsVFRnUEJiQXhzQ2lZd05aUHR2WUllMzI1T3MxdXZWeGRQbEhRcmU4OHhI?=
 =?utf-8?B?MmdMWkdVQU02L1NHc2F6eVZhWm1Ra1pabHpVbXkwZjZaUktiM2ZVS0huM0c4?=
 =?utf-8?B?RHNsWVFEWlAybVRMNTZGWndWL1pJdkMxaGQ1dXpHRERKck1yV1g3dnAzZGNa?=
 =?utf-8?B?ZnJFT0pCc3ZJZXJlK2l6NzA0OWNUazEzSGdwbkhobEY1QTJua3N6Nk9uV084?=
 =?utf-8?B?TjRuV0xvb0tnMitVWTFNQUdTQ1FxUk1lTWVjR293a3lJeWpwZHJ1S3ZmQ1BY?=
 =?utf-8?B?a1B3WHQ5TkU0bE12RGtmb0NjUXc5MUxab2k0czdZNDJROFhYcEVEdUE1ZTlY?=
 =?utf-8?B?Nmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2431c9ed-5aef-45c3-487e-08de24fb4503
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 10:31:14.5862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMimfpMwRw6+LQxLC70O4CT9XX9s2AqEN4tX9KM6hU74Mg/nC9iHeu3T7JXdjvF/Um0+jQLPpybT56/NwUXoS1CEPTBW2uTSFJ+II/KzQlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14605

SGkgQWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJpanUgRGFz
DQo+IFNlbnQ6IDE1IE5vdmVtYmVyIDIwMjUgMTM6NTcNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0g
Y2FuOiByY2FyX2NhbmZkOiBGaXggY29udHJvbGxlciBtb2RlIHNldHRpbmcgZm9yIFJaL0cyTCBT
b0NzDQo+IA0KPiBIaSBNYXJjLCBHZWVydCwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0K
PiA+IFNlbnQ6IDEyIE5vdmVtYmVyIDIwMjUgMDg6NDcNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBjYW46IHJjYXJfY2FuZmQ6IEZpeCBjb250cm9sbGVyIG1vZGUgc2V0dGluZyBmb3INCj4gPiBS
Wi9HMkwgU29Dcw0KPiA+DQo+ID4gT24gMzAuMTAuMjAyNSAxMjowNTowNCwgQmlqdSB3cm90ZToN
Cj4gPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+
DQo+ID4gPiBUaGUgY29tbWl0IDVjZmYyNjM2MDZhMSAoImNhbjogcmNhcl9jYW5mZDogRml4IGNv
bnRyb2xsZXIgbW9kZQ0KPiA+ID4gc2V0dGluZyIpIGFwcGxpZXMgdG8gYWxsIFNvQ3MgZXhjZXB0
IHRoZSBSWi9HMkwgZmFtaWx5IG9mIFNvQ3MuIEFzDQo+ID4gPiBwZXIgUlovRzJMIGhhcmR3YXJl
IG1hbnVhbCAiRmlndXJlIDI4LjE2IENBTiBTZXR0aW5nIFByb2NlZHVyZSBhZnRlcg0KPiA+ID4g
dGhlIE1DVSBpcyBSZXNldCIgQ0FOIG1vZGUgbmVlZHMgdG8gYmUgc2V0IGJlZm9yZSBjaGFubmVs
IHJlc2V0LiBBZGQNCj4gPiA+IHRoZSBtb2RlX2JlZm9yZV9jaF9yc3QgdmFyaWFibGUgdG8gc3Ry
dWN0IHJjYXJfY2FuZmRfaHdfaW5mbyB0bw0KPiA+ID4gaGFuZGxlIHRoaXMgZGlmZmVyZW5jZS4N
Cj4gPiA+DQo+ID4gPiBUaGUgYWJvdmUgY29tbWl0IGFsc28gYnJlYWtzIENBTkZEIGZ1bmN0aW9u
YWxpdHkgb24gUlovRzNFLiBBZGFwdA0KPiA+ID4gdGhpcyBjaGFuZ2UgdG8gUlovRzNFLCBhcyB3
ZWxswqBhcyBpdCB3b3JrcyBvayBieSBmb2xsb3dpbmcgdGhlDQo+ID4gPiBpbml0aWFsaXNhdGlv
biBzZXF1ZW5jZSBvZiBSWi9HMkwuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDVjZmYyNjM2MDZhMSAo
ImNhbjogcmNhcl9jYW5mZDogRml4IGNvbnRyb2xsZXIgbW9kZSBzZXR0aW5nIikNCj4gPiA+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8
YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBBcHBsaWVkIHRvIGxpbnV4LWNh
bi4NCj4gDQo+IFRoZXJlIGFyZSAzIG1vZGVzIGZvciBDQU5GRCBvbiBSWi9HM0UNCj4gDQo+IDEp
IENBTi1GRCBtb2RlDQo+IDIpIEZEIG9ubHkgbW9kZQ0KPiAzKSBDbGFzc2ljYWwgQ0FOIG9ubHkg
bW9kZQ0KPiANCj4gSW4gdGhlICJGRCBvbmx5IG1vZGUiLCB0aGUgRkRPRSBiaXQgZW5hYmxlcyB0
aGUgcmVjZXB0aW9uIGFuZCB0cmFuc21pc3Npb24gb2YgQ0FOLUZELW9ubHkgZnJhbWVzLg0KPiBJ
ZiBlbmFibGVkLCBjb21tdW5pY2F0aW9uIGluIHRoZSBDbGFzc2ljYWwgQ0FOIGZyYW1lIGZvcm1h
dCBpcyBkaXNhYmxlZC4NCj4gDQo+IE9uIFJaL0cyTCwgY3VycmVudGx5LCBDQU4tRkQgbW9kZSBp
cyBlbmFibGVkIGJ5IGRlZmF1bHQgYW5kIE9uIFJaL0czRSBhbmQgUi1DYXIgR2VuNCwgY3VycmVu
dGx5IEZELQ0KPiBvbmx5IG1vZGUgaXMgdGhlIGRlZmF1bHQuDQo+IA0KPiBQcmlvciB0byBjb21t
aXQgNWNmZjI2MzYwNmExMDEwICgiY2FuOiByY2FyX2NhbmZkOiBGaXggY29udHJvbGxlciBtb2Rl
IHNldHRpbmcpIFJaL0czRSBhbmQgUi1DYXIgR2VuNA0KPiBhcmUgdXNpbmcgaW5jb3JyZWN0IGNv
ZGUgZm9yIHNldHRpbmcgQ0FOLUZEIG1vZGUuIEJ1dCBmb3J0dW5hdGVseSwgaXQgc2V0cyB0aGUg
bW9kZSBhcyBDQU4tRkQgbm9kZSwgYXMNCj4gdGhlIGNoYW5uZWwgcmVzZXQgd2FzIGV4ZWN1dGVk
IGFmdGVyIHNldHRpbmcgdGhlIG1vZGUsIHRoYXQgcmVzZXRzIHRoZSByZWdpc3RlcnMgdG8gQ0FO
LUZEDQo+IG1vZGUuKEdsb2JhbCByZXNldCwgc2V0IG1vZGUsIGNoYW5uZWwgcmVzZXQpDQo+IA0K
PiBUaGUgY29tbWl0IDVjZmYyNjM2MDZhMTAxMCBtYWtlcyAoR2xvYmFsIHJlc2V0LCBjaGFubmVs
IHJlc2V0LCBzZXQgbW9kZSksIG5vdyBhbGlnbiB3aXRoIHRoZSBmbG93DQo+IG1lbnRpb25lZCBp
biB0aGUgaGFyZHdhcmUgbWFudWFsIGZvciBhbGwgU29DcyBleGNlcHQgUlovRzJMLg0KPiBCdXQg
YmVjYXVzZSBvZiB0aGUgZWFybGllciB3cm9uZyBjb2RlLCBpdCBzZXRzIHRvIEZELW9ubHkgbW9k
ZSBpbnN0ZWFkIG9mIENBTi1GRCBtb2RlLg0KPiANCj4gSXMgaXQgb2theSB0byBkcm9wIHRoaXMg
cGF0Y2ggc28gSSBjYW4gc2VuZCBhbm90aGVyIHBhdGNoIHRvIG1ha2UgQ0FOLUZEIG1vZGUgYXMg
dGhlIGRlZmF1bHQgZm9yDQo+IFJaL0czRSBhbmQgUi1DYXIgR2VuND8NCj4gDQo+IEFzIGFuIGVu
aGFuY2VtZW50LCB3ZSBuZWVkIHRvIGRlZmluZSBhIGRldmljZSB0cmVlIHByb3BlcnR5IHRvIHN1
cHBvcnQgRkQtb25seSBtb2RlIGZvciBSWi9HMkwsIFJaL0czRQ0KPiBhbmQgUi1DYXIgR2VuNC4g
UGxlYXNlIHNoYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcy4NCg0KDQpKdXN0IHRvIGFkZCwNCg0K
VGhlIHBhdGNoIEkgcG9zdGVkICJjYW46IHJjYXJfY2FuZmQ6IEZpeCBjb250cm9sbGVyIG1vZGUg
c2V0dGluZyBmb3IgUlovRzJMIFNvQ3MiIGFuZA0KY29tbWl0IDVjZmYyNjM2MDZhMTAxMCAoImNh
bjogcmNhcl9jYW5mZDogRml4IGNvbnRyb2xsZXIgbW9kZSBzZXR0aW5nKSBpcyB3cm9uZyBmb3Ig
DQpSLUNhciBHZW4zLg0KDQpSLUNhciBHZW4zIGhhcyBvbmx5IDIgbW9kZXM6IENBTi1GRCBhbmQg
Q2xhc3NpY2FsIENBTiAodGhlcmUgaXMgbm8gRkQtb25seSBtb2RlKS4NCkFsbCBvdGhlciBTb0Nz
IGhhcyAzIG1vZGVzLCBDQU4tRkQsIENsYXNzaWNhbCBDQU4gYW5kIEZELW9ubHkgbW9kZQ0KDQpS
LUNhbiBHZW4zLCBSWi9HMkwgKENBTi1GRCBhbmQgQ2xhc3NpY2FsIG1vZGVzKTogTW9kaWZ5IHRo
ZSBSU0NGRG5DRkRHUk1DRkcgcmVnaXN0ZXIgb25seSBpbiBnbG9iYWwgcmVzZXQgbW9kZS4NCihI
ZXJlIHRoZSBmbG93IGlzIGdsb2JhbCByZXNldCwgc2V0IG1vZGUsIGNoYW5uZWwgcmVzZXQpDQoN
ClNlbGVjdGlvbiBvZiBGRC1vbmx5IG1vZGUgZm9yIFJaL0cyTDogTW9kaWZ5IHRoZSBGRE9FIGJp
dCBpbiBSU0NGRG5DRkRDbUZEQ0ZHIG9ubHkgaW4gY2hhbm5lbCByZXNldA0KDQpSWi9HM0UgYW5k
IFItQ2FyIEdlbjQ6IE1vZGlmeSB0aGUgRkRPRS9DTE9FIGJpdCBpbiBDRkRDbkZEQ0ZHIG9ubHkg
aW4gY2hhbm5lbCByZXNldA0KICAgICAgICAgICAgICAgICAgICAgIChIZXJlIGZsb3cgaXMgZ2xv
YmFsIHJlc2V0LCBzZXQgbW9kZSwgY2hhbm5lbCByZXNldCkNCg0KQ2hlZXJzLA0KQmlqdQ0KDQoN
Cg==

