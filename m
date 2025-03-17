Return-Path: <linux-can+bounces-3149-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E05A657F0
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8013917B83D
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5ED1A238C;
	Mon, 17 Mar 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Gwj5V6+A"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010020.outbound.protection.outlook.com [52.101.229.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FE19DF4A;
	Mon, 17 Mar 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228641; cv=fail; b=px7DlE4KUmdMu0or4SdFL/uCOzx+9TKE99PQDs0Cbj8zjKxc6/2wIu1M+4y2AfJXU1UjeWtzosSOJp+Nb5b6DF6XO6UGXpsp66S4Poepv2ZqjR1BmLGQTGTfXqoGTRLro2jWJeNKRntHH9j5xlByoeNXyHDTGfhzMnCw11c4daw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228641; c=relaxed/simple;
	bh=Hd1ZGklCt6B0/WcPsSda7A6PSl065VhtaOaIwIrpftE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bf9/XvVVcM60fNpq0ynx22iI/TIGf5d2BB1BBISHvTKOnUzs0LMNJWfrCCHcBbLrD/CN9H7VQKF2kGbN97GgXU0FKshO6zEf0HNOWp1cwO0gqqUPSQsOGXMcej79xq6dDMguets4CX3GFqMe1JzyDO9YiwdECrahYerDokoyPcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Gwj5V6+A; arc=fail smtp.client-ip=52.101.229.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0vcfcoQNccDbtCAJ8BKftE+LS1Jj8xT2M5Y5s0qAgc9/e+NtJNgRLidTc3ZWuP5fVBzsMOmmWBZptuFwGxh9A5nIPXtEkcOUb8meeSmmIFWDCVJMKXLw3rXacWZ/e+V7hjHj94UzATJ2YJ21FQ7OEKUh6TLXwMcXzCBqkvYSH+XD3g5MpQ4He12mTXyrNzYmReZHypV7OvKjpgOWqaKMtsyQ/Utjh1vDQzomjwa3eGZQ7I2SDwkAAudAmKgFYrcsYjhZwfLdegmrwPAk0n4X8fe4kc89oGcqUkrcw1xRL+rUlXje1IMaw75va6XdgA7NrjWJbKkIj5+47NfvN433Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd1ZGklCt6B0/WcPsSda7A6PSl065VhtaOaIwIrpftE=;
 b=LLfQLXYWnde7vHBlUc/U9VQw6jJKXSUuEvO0okgJhJKBHJK8qOrcn4kDmjGsd099jnI9aT1yyS+ZLXb/iGW9borRrU71xOx8ki+fIAaeh3s1xgMiFkJ3V2ZXQmJCjgN15iG1MGCV+h7/98C3y4dZf3pNaxxUyRB78C8qi2lGpcPj+NKe/0oafM6zaivwKcibSm4qAkAtxEFYOsWUYuzLO7pt9msS1EZhdyWANySNCfnG2kTZQxwChYlQ3GfbTBkPq/9Yz8ZVaHTwU4oJlENYgCBrM7qA4hwFE1vefmUldUxKu80cB/sqw8Ark5D8IZKMtY8winKpp3YodWIM0ZFn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd1ZGklCt6B0/WcPsSda7A6PSl065VhtaOaIwIrpftE=;
 b=Gwj5V6+A9J5pX8oR1ZU6FVRafqLvyU+nNHZLtp3/3xPBkyt8JkRbnoXpNb9YQ3U9oUIeMAYk5w0D39/VsQOl/RI0y8TiiTJUALiji1Bni51LRjQHscrSN33H5zFhvYsj41lKsfW4dMcj7/DQtthoxM57zpIronAcDlxDRafX7uM=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYYPR01MB12145.jpnprd01.prod.outlook.com (2603:1096:405:f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 16:23:56 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:23:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Thread-Index: AQHblzlRqz9AKXyTHEGDaGzuM2Z5HrN3XvaAgAAGwaCAAAdpgIAAEBGg
Date: Mon, 17 Mar 2025 16:23:53 +0000
Message-ID:
 <TYCPR01MB1133298C8595B3CA5D890289486DF2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
 <20250317123619.70988-13-biju.das.jz@bp.renesas.com>
 <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
 <TY3PR01MB113466DCECC55DDE9913833F186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdXbk8gqhd4FFGmFNQRrEwbOToQvr-00LE2pZWoZq65GGg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXbk8gqhd4FFGmFNQRrEwbOToQvr-00LE2pZWoZq65GGg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYYPR01MB12145:EE_
x-ms-office365-filtering-correlation-id: 825d356b-f9b5-4fc5-062b-08dd65701c08
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzdWOVhGQ0VGNlRSOHlJOXNxOEJTM0hZS3NBeTEyeE5QSXV0VW16N1VQeUFk?=
 =?utf-8?B?SGZBbjVkOU5WRmwva2p2b3ArRlBDM0IyWitEY1cySkhMWFpUUUJIVnozUi9l?=
 =?utf-8?B?R0pYWUx4WlJJZVkvbzNCekg3QTY2TldDTHg1TysvbDlDTkphblhNMDRPVVZx?=
 =?utf-8?B?MkNhVnh0RlRhNWxuWjNCclBtdGFET1J2b2NtODRKVXZjVkVTWjdQYUpyQWla?=
 =?utf-8?B?Q0k5dE5pUGU1Q2JlVUdlQWVSWmxlbVlybnFLRE00NlAyMVNMOE85T3VTRjZq?=
 =?utf-8?B?NmtyYWMwamJtUllYRGJTVndVc25wM0ZJUFkwV3Q1RFdwUGt1V0xPc1FOZ25x?=
 =?utf-8?B?TnZiWDhEZGJheE5qeFo3UUxxUzQvMi9jK1BLUVdLbXVBSzZaaWhGVkRlU3lV?=
 =?utf-8?B?Nmw3WnRNOEJ0YzdJQy9jRVFYdElQc1Q2eHk2QmNGVFVYUythR2ViVGpRby9M?=
 =?utf-8?B?NUYxZTVEbjFPdmU3RktSemU1R28xdDlJdGN6aEdyL2E5ZTBhWFRJc3lubDc5?=
 =?utf-8?B?ak9FVjlpUUVWNmtkNytWRThLenpaQUdEUGF2MnBCRENQdTErVWNaZFR0OUlP?=
 =?utf-8?B?d0U5Qng5QVlZa1NNci9Ueko1SUdVQWwyczF2QjU0aUFLallKMlVKRWRWdjB6?=
 =?utf-8?B?MzhDaGpTOFpMM3RVOVhweWYwT1NGUHFDSXdNc042K1B6NnNPeFQ0TC9BWjFV?=
 =?utf-8?B?azJjWGRRZDlkZkJERVRZTkNwVElsejJ4Ykxha2V4NG1mM3JUWXVzb3MrcHdi?=
 =?utf-8?B?UjVvckVVK1A5dmc0blJhbHgyRjFSSXErelNuc3BGcTIvM3phakdSelQ0SnZG?=
 =?utf-8?B?ekI1eHZDNEtIcXI2eGwrLzNwR1RoSEprTDJaOHJLMmRVcEZmcmk3SzZRc2JP?=
 =?utf-8?B?TEZTNlhiOVp5ZlFMSElMVnJ2c0JrQzEzNXlYMmJiSlhyejhXL3dnQ1FIV00z?=
 =?utf-8?B?dXlWeEI4aXBpYWg2OUZyZnBSUHNyNGVCR3pUMWVPejF2MWV6T0wxbHpSUTBB?=
 =?utf-8?B?dEFuTWlETERTeVlQWi9wei8rUU9LWUY5VThDd0V0bGJUTGsrU1ZPcEZZdzVy?=
 =?utf-8?B?UHJvWVFVVEdoZDhLNWd0TW0reFZobDJlRjR2TlpaY1RZVmlSbXMzWHpVRmxS?=
 =?utf-8?B?WmtwZnZaTWo3L1ZWbjI1OThoR0FKLzA0STBENDQvZXNzdlJnNndMNlh5ZzJT?=
 =?utf-8?B?Q0E4aHFXUmR5b0dXK2Y1REQ2aXBYY1pTV0ExaTNsMmdwbm9OaVExR04xZDBI?=
 =?utf-8?B?VlVtWXMrY1lsUW9EQzI4S0NyeWo2dXJ4M05LRytyL0R2U0FHTUM4SHlDem96?=
 =?utf-8?B?TkJOVnRhbVN1cHpIT0dBRXNBZ3c4NVB0N1RpekVXc2hBZGpPbVQ0bUhZNkZh?=
 =?utf-8?B?SDdDSWkxeTF5VXBvOGx6MUgybjZUS2RUelRlQVA3RXlHMlBnNUR5UVU1WEhp?=
 =?utf-8?B?MmVaVlRoK2JSdFowUUl4TGJBZ3NkdWJrd04wSGdiTkR6dFdnQ3FsZlcxTURY?=
 =?utf-8?B?YzVoZU91ejY4YTNjWEJFdmZOYi9aRU5MemUyTDltQUd0cm55VjFnQnB1bDRK?=
 =?utf-8?B?SStUZE5OMDFsMHJHcm82NElUNDk4UkF4SCsvcVpzUU5SVWhiTWhxVy9kWVhB?=
 =?utf-8?B?b3dKWGQ0VHZvOG9KaitEbjVSN1FVUXNLdE40cUNCMG5ySjNPQjFuVkQzUDYz?=
 =?utf-8?B?NlYrRnpWR3JzQlprQVZlcFI5RUZYS3ljbjVaZEJtZkNOS3JYQ25QckVZdHNZ?=
 =?utf-8?B?RmcrejVQSVQraDFQQ2lkT05GaEVPUG1HbGVOTS9kNFdQSnJtRzlBYU9hZE9E?=
 =?utf-8?B?dGZ5QjRuTG1nOFFka1BwQjZHeWdtbnVCMGdscUkyRHluWW1aNGNTK0NjTU9R?=
 =?utf-8?B?S1NhNllIbXZ5TysrNG9ZSXM2WmI4dU1IUUdGaWkzWCsrVEFIOGxUNHg5QThy?=
 =?utf-8?Q?nRRMNvQzAG/HLSMl7SCDktHZZbdRI97R?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0R6RjFjcG8vZ2E4UnlmL0NJQmhsOW9BS2hZeDU0MXU5a3N1Wmd0Q0Rpait4?=
 =?utf-8?B?TW9XMXRpMEFaM0ZzaWhPMlN0TU5ybVd5TkR5S1RIMC9QcGRmSmdaYzVoVU1S?=
 =?utf-8?B?M1YrOWlIYUIwb2ZiblBGWUZ1c1ltR1o3U1h1ZjdmR1B6TjNRYzlzZUZLTFdZ?=
 =?utf-8?B?cVhUOFVkNFI0enNJOWh4NnlyQWJJd2RaTmlsdTFNc2xjM0YvQk5BTU85WDJz?=
 =?utf-8?B?QnB3M3RZMkIvTS9RbXgyQkJkZFYyUzZadjE2TFhZVUtjVGpLVm5ZazBxWnlB?=
 =?utf-8?B?S2hxbUhTRlNFWHV3di9HWlk0OVF1VzRmakRoTWdkK2ZpVGYwU1g5b0lMcjdk?=
 =?utf-8?B?b1hQZHNyR0FLNWZTMEFCNkkzR3c0emZrT01hTmlLcnNUSHFBNUNvQnNnaWRn?=
 =?utf-8?B?WFNSVUFZb2tVKyt0WVZGdnVlbkJ5SGtVMzFIa3llUjJaVXdlN0dFbC92Q0Ji?=
 =?utf-8?B?ZDVmeXdFQmxqRkcvcSttWkV1Q3BPck5wRW9yeUJYR0NiOExnN2JOcmNxaXZ0?=
 =?utf-8?B?dENkSXBKd1NRTVQ1ZG9aU2dkdzBOYnY4ODhiWENUUkxVYmI0Qmg5U3N4bHd1?=
 =?utf-8?B?RHFyMHhjeCtNYVlDRU55c2U4WkJHdkhONHM4Q3F5L3NYU1JOVmlaTFl4U0Ry?=
 =?utf-8?B?eERuZzF5TVVLSE4yODlHcmhFUHdxR0VNK3pKaHlpTDlRK1c4T2RwYTE0anVQ?=
 =?utf-8?B?YzY3aFg2NFlud2F6OXF6WGJ6Q0ZPbkJxMkd3UEhhVXV2RzFPMmRkS3ZZakFK?=
 =?utf-8?B?a2tCNkk0em9aWURJL1UzcEFNdllPamJ6SGJmLzBxTmVsMTQrSTh4eGVaUkdp?=
 =?utf-8?B?OE1wZUNXS2xUWjZnNzFIbWJsNHBrYmh4L25GVmNQbjlGZnFwUnFJL3R1alh5?=
 =?utf-8?B?dmxFbHpwRGxwZ0VkeFlXalNRbWdPdjY4ekxOWUtac1BubHpxK3FBbW11WExE?=
 =?utf-8?B?bkdoamY4ZytmK0VXOE5NTlVvNWhGOFl3SE1PcHZHb0s3dHhQekRlWXQvQTdh?=
 =?utf-8?B?dzJHbkg2MHVmWDN0Q2kzTmlEZ2RnQW9QRlpML1Q1dUswVXJYTzM4NGVGMW1Z?=
 =?utf-8?B?OGhOaDNJdmdqUWUwaGw2b3h2eXlITkZFUSt5djRNSFZJNVp4L0xWZlQ0emJZ?=
 =?utf-8?B?WjRnYmpPdnAraFJ1RlFJdHpoMjVEckdBL2l4Y01XNXp1bTF4RkYvcXpOdzh0?=
 =?utf-8?B?NFZOOXdESzFsYmhXVkEremQ2SERvZ0hSdTZRSlg3dEV3ZmpPZXpJWW5sWnZV?=
 =?utf-8?B?NFdyeU5reXd1SFRXMkw1SEdQd0xFRnUwVDkvNldpT2lQL1BMUEpmNEpuOWtz?=
 =?utf-8?B?czhRMmxmRHVjOEE1TzJUdlhaVG5zK052VjU1cytTU0IrWWZYcnN2Z2l3SFNV?=
 =?utf-8?B?MjJhME9mNkJFMVNsckw1VG1sdW5GcE5Wd0NBOVBDUHlEUE9FbzVaKzJydnZm?=
 =?utf-8?B?azRrYkk0WiswcXNPcWFJWVJCVmZLVGdMazZXNUpjMU5HRmlaRlNaZ3BJdm1s?=
 =?utf-8?B?WFhRWC9EdTFid0Q3MTBCejlBR0ZtZS9FNXFTQUs0R3l2LzN0Wk5zd3BhNXBY?=
 =?utf-8?B?NmZpeWhQcW5NVnNsTitVTVpHb0VkMkVhYXU2Mm1uZWx5SVFpNEh4U3ZmaElP?=
 =?utf-8?B?eEFsQ2ZidlFmZmthYy8wK3V4REZaN3FCOHFNbmZkWFJ2aVBobTk1VzNiUzlX?=
 =?utf-8?B?dUxTR2dPRjd0Tm9kSWN2ZGx6U0FtQU5EWUxIckNXSlA1cFpVeHBneU0zaDNB?=
 =?utf-8?B?VFVUNTBwVTExR01od29PbUlQbE9aTmRNSkRRSlZwS2JMTnJnN0w5K3NsTWh0?=
 =?utf-8?B?RVU2TEJTeThxUXk0QkJQVFY0dW5WVDFxeEdPclg1UWlWWFpqeitEU2ZoZHo5?=
 =?utf-8?B?b3FsbFp0MzRXeWpHaHBiZ2RaM25yUWNqR0dpUGxJbFRLMlJnd1QrVnBycVhV?=
 =?utf-8?B?TUhaSEd0NUNXZzB1ck5OWlNGbHl0YzQ2dXZxeDZxVGVGTG1GS3JUcFlKSUEz?=
 =?utf-8?B?S1MxUy95ZTQ3cVUzd0w2bCtocllzQlhKNkM3WGlhZVlNa0daNmQxVnFrcDF5?=
 =?utf-8?B?NXJPajV2YThBdE4rcU8wTnZmWDQwM2diN3hBRHUzY0JOR1BLYWF4WnZUanJl?=
 =?utf-8?B?dGRZQlNDZnJPNnB6bXFiZmRRcnp2b3hNWUQ5bFBEaDZPZDlTRUovZTdnejJH?=
 =?utf-8?B?OXc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825d356b-f9b5-4fc5-062b-08dd65701c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 16:23:53.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Obc+iTmeVBCYmWVZommPIt6LEl3wDYDxdTQJD4B4S+wik9mKVKFTYSfExd4K4cLqAUOxcNb24tiG6pe+0dAe9LNbxHX5ANfpI8Fjbf3dz4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12145

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTcgTWFyY2ggMjAy
NSAxNTowNA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEyLzE2XSBjYW46IHJjYXJfY2FuZmQ6
IEFkZCBtYXNrIHRhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4gDQo+IEhpIEJp
anUsDQo+IA0KPiBPbiBNb24sIDE3IE1hciAyMDI1IGF0IDE1OjQ2LCBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5v
cmc+DQo+ID4gPiBTZW50OiAxNyBNYXJjaCAyMDI1IDE0OjEzDQo+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY1IDEyLzE2XSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBtYXNrIHRhYmxlIHRvDQo+ID4g
PiBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvDQo+ID4gPg0KPiA+ID4gT24gTW9uLCAxNyBNYXIg
MjAyNSBhdCAxMzozNywgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90
ZToNCj4gPiA+ID4gUi1DYXIgR2VuMyBhbmQgR2VuNCBoYXZlIHNvbWUgZGlmZmVyZW5jZXMgaW4g
dGhlIG1hc2sgYml0cy4gQWRkIGENCj4gPiA+ID4gbWFzayB0YWJsZSB0byBoYW5kbGUgdGhlc2Ug
ZGlmZmVyZW5jZXMuDQo+ID4gPiA+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJo
b2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiB2NC0+djU6DQo+ID4gPiA+ICAqIEltcHJvdmVkIGNvbW1pdCBkZXNjcmlwdGlvbiBieSByZXBs
YWNpbmcgaGFzLT5oYXZlLg0KPiA+ID4gPiAgKiBDb2xsZWN0ZWQgdGFnLg0KPiA+ID4gPiAgKiBE
cm9wcGVkIFJDQU5GRF9FRUZfTUFTSyBhbmQgUkNBTkZEX1JOQ19NQVNLIGFzIGl0IGlzIHRha2Vu
DQo+ID4gPiA+ICAgIGNhcmUgYnkgZ3ByaXYtPmNoYW5uZWxzX21hc2sgYW5kIGluZm8tPm51bV9z
dXBwb3J0ZWRfcnVsZXMuDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0KPiA+
ID4NCj4gPiA+IEFsbCBtYXNrIHZhbHVlcyBhcmUganVzdCB0aGUgbWF4aW11bSB2YWx1ZXMgb2Yg
dmFyaW91cyBwYXJhbWV0ZXJzLg0KPiA+ID4gSGVuY2UgdGhleSBjb3VsZCBiZSByZXBsYWNlZCBi
eSB0aGUgbGF0dGVyLCBsaWtlIHlvdSBhbHJlYWR5IGRpZCBmb3IgdGhlIFJOQyBtYXNrLg0KPiA+
DQo+ID4gQnV0IHRoaXMgd2lsbCBpbmNyZWFzZSBtZW1vcnkgc2l6ZSwgcmlnaHQ/IEN1cnJlbnRs
eSB3ZSBoYXZlIHJjYXItZ2VuMw0KPiA+IGFuZCBnZW40IHRhYmxlcw0KPiA+IDIgdGFibGVzIHVz
ZWQgYnkgNCBoYXJkd2FyZSBpbmZvIHZhcmlhbnRzLg0KPiA+DQo+ID4gSWYgd2UgZHJvcCB0YWJs
ZXMgYW5kIHVzZSB2YXJpYWJsZSB3aXRoIG1heCB2YWx1ZXMgbGlrZSBSTkMgTUFTSywgdGhlbg0K
PiA+IHRoaXMgd2lsbCBiZSBsaWtlIDQgdGFibGVzIGZvciA0IGhhcmR3YXJlIGluZm8gdmFyaWFu
dHMsIHJpZ2h0Pw0KPiA+DQo+ID4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgbXkgdW5kZXJzdGFuZGlu
ZyBpcyB3cm9uZy4NCj4gDQo+IEl0IGRlcGVuZHMgd2hlcmUgeW91IHN0b3JlIHRoZSBwYXJhbWV0
ZXJzOiBpbiB0aGUgKHR3bykgdGFibGVzLCBvciBpbiB0aGUgKGZvdXIpIGhhcmR3YXJlIGluZm8N
Cj4gc3RydWN0dXJlcy4uLg0KDQpPSywgeW91IG1lYW4gcmVwbGFjZSBtYXNrX3RhYmxlLT5tYXhf
dmFsX3RhYmxlLCByY2FyX2dlbnszLDR9X21hc2tfdGFibGUtPnJjYXJfZ2VuezMsNH1fbWF4X3Zh
bF90YWJsZSBhbmQNCipfTUFTSy0+Kl9NQVhfVkFMPz8NCg0KQnV0IFRoZSBBRkxQTiBlbnRyaWVz
IGFyZSBub3QgbWF0Y2hpbmcgZm9yIFJaL0czRSBjb21wYXJlZCB0byBSLUNhciBHZW40LiBTbywg
SSB3aWxsIGNyZWF0ZSBhIHBhdGNoIHRvIG1vdmUNCnRoaXMgZW50cnkgb3V0IG9mIHRoZSB0YWJs
ZToNCg0KQUZMUE5bNTowXSB2cyBBRkxQTls2OjBdLg0KDQpDaGVlcnMsDQpCaWp1DQo=

