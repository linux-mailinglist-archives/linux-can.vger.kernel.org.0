Return-Path: <linux-can+bounces-3257-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E747A747CC
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B739F3BC2A2
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE43213E66;
	Fri, 28 Mar 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Hdlusw6Z"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011032.outbound.protection.outlook.com [52.101.125.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6342213241;
	Fri, 28 Mar 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156924; cv=fail; b=RLvgQcf1goeZwmBjayPLU3AzeYjewgY1UfhazT03c+fx3MdmtKbbnG2AII+ZTZyon8nk/TvD7i//CVRpH2cX3Xc6yd2NJ76CZ0vxWHF3SUzOuPX2YTdNr0SYQ/vOelal4/mlz0laKAy9JxHSFkpQon5lip4aEDoMICACFBxdSLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156924; c=relaxed/simple;
	bh=f4tcRS+nrIkVQT4rOQiUuJJyFPGolh0DxlJ1mTb38q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ARuIV/lD7or3npqL2B2a0/4PEYOatmTsV3rCqMGHsof1VIHYzu5laRY4gJ4/kyo/IyxzsQRydylIFSAWy9XNhyo+ZQSRTWiGruKNnbDVVaSRyEu7FPLAKI+Iv4IN4DsIR0dBLhhONsp2HnFkKirjWJIu87dOJMXp08z/X+j/aOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Hdlusw6Z; arc=fail smtp.client-ip=52.101.125.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7MLaiE1Be5fCSp60Fi+TlYjKg+lNvABGY8I+IYFIpEgi8LkgJrbBjfJNlB33lRYFvufPSvlvxGFz5BNBW341qAuzdKQvny2i8myegHg/EpsI6nS6CcQ76ySBjzYLNhCJEkde0faJbUxh2VB01MPI+vRneq10FVv+AacKX4G570DUpI0FSfwFQiCDo4iQ4pIMT3lZFdIREyMcuL1Zmf0B+x7ZORN2bUoeFA3yL0CKc1FZhi6grcsFPI1RPTgI/+fgUTiHFMm8lUaAa/ondVP6gowMe8+gjpztmMrJsXY1tW/gLbPOhhpt23V/GUZ7cQRQTEUUu1N+bBsFkJvjPZA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4tcRS+nrIkVQT4rOQiUuJJyFPGolh0DxlJ1mTb38q0=;
 b=mzetI+u0rNXzsD1QGut/wd1qVflat9CYsehIp9p71PlOnud5OTLn9CGX20Kqovyd/fKYka5a+ZuvUFsfLcgbVIi3KiacJAJEzgD+blp3uUfTGfKNGFhpNcS5ozU2DNRns95Vx9Jgn+xyjuD5LAhT0kGsNF0CTQtxEs2vNPl8NnWMpG82JNyAwZbnsBk06hPrPHtVuVmPDIdiQuY/FNBEzWUpLF+IaNupLE/+sdxUPkfyfqtxx9416sN/3Wl3U74W1MWYwdmh+s9fS88RQRUewBL0mXsY8/uG1Le8AdvhkjqjB5xTOL3UN7Ww16fSGK6I5+/vo8S9FBZpBZ/9ivwNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4tcRS+nrIkVQT4rOQiUuJJyFPGolh0DxlJ1mTb38q0=;
 b=Hdlusw6Z5f/Jcmhbp3IH07Qq6J9qpG1J0sCnikZQq25fmTVBRkCCGvkT81xfg0H7GtTbSThzyt8zeo5xZ+KeALCyyEJJ9KRgCkDefNyUgfzKXYKz/64NRTssAs0cttdbS303ui6+0W4mL5GFf3iP7dNkuIXpE5tHrkKkgKd5Buc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB15077.jpnprd01.prod.outlook.com (2603:1096:604:36f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:15:16 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:15:16 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Thread-Topic: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Thread-Index:
 AQHbnkl63JoFqVndWE+hQB80zsNhELOIReiAgAAAqiCAAAbcgIAAAW/wgAAHzICAAACyUA==
Date: Fri, 28 Mar 2025 10:15:16 +0000
Message-ID:
 <TY3PR01MB113464539C208D4A1AAF403A286A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
 <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
 <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUacYqUd_iPk95C3+bc64SeMbDj1=zdfLvuMHFbTRS39w@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUacYqUd_iPk95C3+bc64SeMbDj1=zdfLvuMHFbTRS39w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB15077:EE_
x-ms-office365-filtering-correlation-id: e29139c7-3e76-4cd0-7f40-08dd6de16fcf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUxnOXAwL0Z5NS9IeHVSVHYxaFB6V09OSEpCK0NXdG02aGRMemo2VHBzV0I0?=
 =?utf-8?B?OVE4Y2xhd3M2ay83Y3RUZ1BsTkZJc29JcHdObWdKZ1c5bjIyRFJIam0rQ3RI?=
 =?utf-8?B?dHZoN05SMno2OE9VYkhmZklGSzVsN2tLcjZRc0NxQllFWVFoTWUvU1EweitL?=
 =?utf-8?B?d05XdFpVWTRKaXlUK29tTjBlbEhKeHFjckxvQy9UNndKbE5KSURoQnAwS1Mw?=
 =?utf-8?B?Y0J6cHJHYUp2WlcrUHhhaFJGUHJLcUNkcmswcWJDWURNVi9pR1REREN3Sm80?=
 =?utf-8?B?ekZKanVwZVYxNVp1U01vTmdTQ3d4S3p4RDVmOW44WmcvT2NaOU4rYjRlbkR1?=
 =?utf-8?B?Z2tLMGpQM3JTQU92K25GVE01ZUFFTVJRK3VmRHpsRmUyRzQ0Z0V5Nld6T3VH?=
 =?utf-8?B?Z2ZhWW1EV1RPSlAwT2p4aXBFTXhkWkpxRFJPZFcxcmFLcGkwMlZhQjR5cG5p?=
 =?utf-8?B?VTl2a0gvTWtUSWhEenpkZ1ppR2NkR1FyMGNzVWRTRUNsUll3WW1YSGpGMW5h?=
 =?utf-8?B?b0RLYlRCTElrRG4vZVdURUVYRlhVRnkrLzFES3RwVWw2a3J5YXpPTlc4UHZE?=
 =?utf-8?B?Qng3WXR4MTUzRFV1NTFWbEpISHpYRDJvN2tRakJjNVhNai9wNmpNWHNXeTU3?=
 =?utf-8?B?TFVQQkVPLzdxeHppbVc3TWtTVk1pU1B2NjJHRHdsTGpmTHV0bWd2UXRnZ0lO?=
 =?utf-8?B?M25BY3I4VFIvdFg3TFo2OEkzQWUycHI2RU1idXJmeVhOY1A4dUJEa1pRV3ps?=
 =?utf-8?B?N3JMVnFEWmRkQTNQdm1lb2hkYksweEtNbnJOOUszMWNaWWk2NCtMd0svSHEy?=
 =?utf-8?B?ZGlEVDhxRU5aZG1BQXRncUF0UitwcFFUcVJIeGpqUE1MVnE5RFprVndnd25J?=
 =?utf-8?B?b0Y4YitxRjZjTW03ZVVHS0M3MTdHSk5Sdk1aVU5CM2JsZ0hWSWN4SkZMVncx?=
 =?utf-8?B?QlhjbXZ6WXJWWHZ0TCtTTzhoWVlSL1R1amNxOVBPK2dqWUo2Q25vdW1HZUlu?=
 =?utf-8?B?L0xYUlIzV0VGZGp2RU9wRWpSRDlMNFJOTHJQclVWbjJnVk9BYncxMjBWRytm?=
 =?utf-8?B?eitCcml0Nmt2amRMakg5TTZsQWk2OExkMVl1eTdDU2RuWm5GQnYva0paN3Jt?=
 =?utf-8?B?TnJ5Z2xpTmtuVTl3a2dwb2FEWEFheU9WNWp5TUZXbzdsQVJDenh2K1MvQnNl?=
 =?utf-8?B?cW1nTTNzWjdNOXliWDZDUmhPcHhLdjN0RFc2VUROOXluaE5kQnBjc3liTUd1?=
 =?utf-8?B?aXJnTWVzdFJlaEhLZ2t6WS9OalpsMlprNmFoUVVyNnFXRzlhVFhaRUxqWDBL?=
 =?utf-8?B?aTNsQUdEc0VOM0x2c2RoVjNLdFVlK3lmckI3WVJ1YkQrRXVUaDFvdloxZ1du?=
 =?utf-8?B?MGcvR0VxeWhXN0F0dFFCcjhWbTc0NEVxU0MybWxOWmxmbFZMc2s2SFNqM2tv?=
 =?utf-8?B?MC9KY3JuTlVIN3RLVEZBaDNpOUhES2JlRHZNSTBmN0dma0Zvb2JYZ2FOTTZT?=
 =?utf-8?B?THNFbVZHYUd6UDRKNDIvUnFkeG1CNC84bTdlVWdmakxuMFFLTlA1OS9PdGRs?=
 =?utf-8?B?djR1c0lJVUxmTTd3dFUvL2hkajk2L1NUNzVvWm4vMytDYnd6NUlicXhMUlpl?=
 =?utf-8?B?THdXSlNsNWhXMEZpdnArRld1V2VZMXBYNi90ek9MWXVuV01pZGZxQjNYeDhk?=
 =?utf-8?B?cFFiditJOEY3dHZVTk5sd0tIY2tlNlphdElvM1E3STdYRG1Va2hlNGxsM0Js?=
 =?utf-8?B?Vk5ieEhQVEVFS3k2WnozcXUxRmNad0Q4SlVHOGtXVTlKeGlsWTVPd1NEZWlQ?=
 =?utf-8?B?S3ZmQ25scnJPMXJqNXVTMnF4MUNEOWlxV2RMTTkybDYyb0MvbWR4ODFXVTZh?=
 =?utf-8?B?T1RuY3RVVXpqaWJrdDkyUWlHaFVybzd5aWlXczNta1NHcm1iT01kUC9OeEZo?=
 =?utf-8?Q?lSxWutfJ7336CVMuhfuovA6Y1OXm2ZrE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2kybXVGM2JaeWUycWd3QUZoRUhGVnIxOE1tQ2ZnTkl4ZHhPMGQ3RXkrS0dU?=
 =?utf-8?B?QjIva28rUUJzZzZBeVdNdDhpLzhRREp4SGlSaDE2UzlkM1NwYmlrTUxxdHJt?=
 =?utf-8?B?K0JaOXJHWnU1WWR5M05xcWJmWmpaVU1QSldvdm9QNkE5akxjOXhnYVllS3Y5?=
 =?utf-8?B?NzgrVytTZk5lbFR1L0hLekh4MG1Vdzd3bVBmdU5Ga0FLVmJTRG5yUFdDNEc0?=
 =?utf-8?B?ZG5zV2cwUTJEelg4VVBIZExIV1BWeEFvRXNwZEUyTnJPU3BoVlZUNEo2UGZZ?=
 =?utf-8?B?ekJheCtNaFJhdllPZUEyZzF2MDdPUDZnalpnT3Z6TlVBd1R2aS8vdzVzM1g5?=
 =?utf-8?B?Y3dzOENCUGR6TjYrcVZPNzVEYzBjUEdWc0hXNjd6WDFtdUEvMnhWemdhMEJF?=
 =?utf-8?B?K050Ui9BS29QcGNQQUtaQzE4TDJaQW9PV0NpdVFESDJJdjllc0hqTWtDMGg1?=
 =?utf-8?B?Vm1aQUVBYWw1TGdFWjRITW5DL2Q5c3kzVjRYQ0NNTDhtY3NBYS95dGpVNEow?=
 =?utf-8?B?Mkg0ZEEwSEhvZEFyTTljL1Z4T3NyakxBcTZFUUJGODVRV1R3N3lFR3FxV0Zu?=
 =?utf-8?B?U2UzQ05LM3hKdGI0RmR5anozSUJIaUFCZEkzVFlxZTBISGxwcmVER0hjUDJM?=
 =?utf-8?B?UVBlNVlaWDBOaFQ3NXNiYlV6NjVSSEliL3Y0NGgyYmE2c1R3bGFRUU1oTDcz?=
 =?utf-8?B?OXFBLytWK2E5a3dtY0JSbmdJQVNYaEU2dmNVUGt5dFhGTWdaOWZSNEFENUs0?=
 =?utf-8?B?TFpzNmdzdHIydTNWNFJtWTdCWnhqQko2cDlDQzNYUkdzY0VuRkxueHUxQWJo?=
 =?utf-8?B?M09odHNYbDJpQmFFVStWa1k5azJiMFpyQXVEOGhkVlRHdDBVd3pna3B3U0JC?=
 =?utf-8?B?REVSR2o5R3R2QysrZm4rK2lRZlJkQU9CMSs5SGQyTDJYd09SS2V4RXVRNksy?=
 =?utf-8?B?UCtoVmRxajU5YXg3NnlPTUZ6SFhPRkVZRkpWbnJKVEtJOEM0SEhFWFRMY243?=
 =?utf-8?B?TVNrMEdCRnM0SXJCRWdGTlBOcWlqZEo3MkdQMmNzSnphMGdiZEkvemhPZEZ6?=
 =?utf-8?B?M2twY0tmWmptT1g4Mk1qak9IVWt1ZFp6MjJSUWNCL1g4TEk4WTZRbDQ3dUNV?=
 =?utf-8?B?RTRnLy83bkxhNUhDQjBoTEtBOG43Z1l1Z0pHRnpsSGl4QjFsK1N1OTQ2cTB4?=
 =?utf-8?B?MTdSdWpwcHpLZTlNUHJlWjc0eFJQYk13c2dpYkJINHJ3T2NjcDVITmtJYy9t?=
 =?utf-8?B?MXAvMEEzUGwwRDZ4bFlHT0xyeE5zSVkyNE9hYmtheXV3VDNNdTNkVGgyZ0d6?=
 =?utf-8?B?OGdhaVR2NDBJTGNkVlQwdnZvYVRIdGNoYStaYXljSGowQ3orK0E4b2ltQ2hi?=
 =?utf-8?B?WitLS0s2TG1sMUo0RTBxZlVlZWtnMDlKZXMzbDh0N0FjVUVWMmoxUDNQT2wr?=
 =?utf-8?B?cFJYMmZPWkN5QkJPc24vRFZwbHVDSmlIOEZacWoyRG9Hdm5MU3ZYRVNRUy9G?=
 =?utf-8?B?VHJYdGxHbFZZaGFsam5YNXZkM2MvU0lPeWMrMGNSVnhZRCtwUTQ0eUsvMnFn?=
 =?utf-8?B?OXAvZUVwUXhaSVkyWGhuSUpZNnBUeUIzbmtEUlBZYVl4amtqODdQeGkrbFNS?=
 =?utf-8?B?eUxySzMyM1Y5VGVGNllvSlNGNnRqSCtFWWwzbzBVYTJlYnVHZ1ZpSUtvNzN0?=
 =?utf-8?B?OEF1RUhVdnZiSlJ0dFR6QXJ4Rko2dG5BWkM2bUNEZHVMc0cvVlJxVFZjdmdx?=
 =?utf-8?B?cWpjMEZ5ekZyY2thRzQ2MUFKMUhoRWJmVXFJcENvS2R5WXVoY0UyMGdJVHEw?=
 =?utf-8?B?eTJmR1JUbE5YVGlSYUFTSnVLbEs1UVdLTmg2d2VpOXFVcW1UeGJ3aHRQSVlW?=
 =?utf-8?B?bEIxTVpUeUl1Y0twOTFyN2VnM2dpd2cxUmx0aDNJTjEyNHIxMTRXcDl3NEJx?=
 =?utf-8?B?SDkvemtkRTUvSDZQVlEzNE9POTNSWEVweEdlRURjUGFLU1h0TXl0UTRBTTgz?=
 =?utf-8?B?NUJscEd2NDY4YXNSSWZxZFZUdlN0QXU0aWFNcDgrYm1hemsvL2FrYStjcDZ0?=
 =?utf-8?B?ZVlJbEhJNWdQZnNWbTBsQTdtUGxxdU92dVJBWjV6UGtyQXNqUnYrbVlkTWMz?=
 =?utf-8?B?T21PWmE1ZldSLzNmQWpFQmxIZ3doU1pLRHdGNW9pSHNML2toaDRHditKUUdT?=
 =?utf-8?B?Ync9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e29139c7-3e76-4cd0-7f40-08dd6de16fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 10:15:16.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iik/G8cxD1ltC8AsuIgiep2BaeVzvESIKADFhHRUq8I+Oi78rNs0nQffqa5aJp72NbRBMx0Pjr0EvIZ6qUQ7nUyrHJxXu3QX/fNyeIEIK60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15077

SGkgR2VlcnQgYW5kIFZpbmNlbnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDog
MjggTWFyY2ggMjAyNSAxMDoxMA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDA1LzE4XSBjYW46
IHJjYXJfY2FuZmQ6IERyb3AgUkNBTkZEX0dFUkZMX0VFRiogbWFjcm9zIGluIFJDQU5GRF9HRVJG
TF9FUlINCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBGcmksIDI4IE1hciAyMDI1IGF0IDEwOjUx
LCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gRnJv
bTogVmluY2VudCBNYWlsaG9sIDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4gT24gMjgvMDMv
MjAyNSBhdA0KPiA+ID4gMTg6MjEsIEJpanUgRGFzIHdyb3RlOg0KPiA+ID4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4+IEZyb206IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhv
bC52aW5jZW50QHdhbmFkb28uZnI+DQo+ID4gPiA+PiBTZW50OiAyOCBNYXJjaCAyMDI1IDA5OjEw
DQo+ID4gPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDA1LzE4XSBjYW46IHJjYXJfY2FuZmQ6
IERyb3ANCj4gPiA+ID4+IFJDQU5GRF9HRVJGTF9FRUYqIG1hY3JvcyBpbiBSQ0FORkRfR0VSRkxf
RVJSDQo+ID4gPiA+Pg0KPiA+ID4gPj4gT24gMjYvMDMvMjAyNSDDoCAyMToxOSwgQmlqdSBEYXMg
d3JvdGU6DQo+ID4gPiA+Pj4gVGhlIG1hY3JvcyBSQ0FORkRfR0VSRkxfRUVGKiBpbiBSQ0FORkRf
R0VSRkxfRVJSIGNhbiBiZSByZXBsYWNlZA0KPiA+ID4gPj4+IGJ5DQo+ID4gPiA+Pj4gZ3ByaXYt
PmNoYW5uZWxzX21hc2sgPDwgMTYuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBBZnRlciB0aGlzIGRy
b3AgdGhlIG1hY3JvIFJDQU5GRF9HRVJGTF9FRUYwXzcgYXMgaXQgaXMgdW51c2VkLg0KPiA+ID4g
Pj4+DQo+ID4gPiA+Pj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVu
ZXNhc0BnbGlkZXIuYmU+DQo+ID4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiANCj4gPiA+ID4+PiAtLS0gYS9kcml2ZXJzL25ldC9j
YW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+ID4+PiArKysgYi9kcml2ZXJzL25ldC9jYW4vcmNh
ci9yY2FyX2NhbmZkLmMNCj4gPiA+ID4+PiBAQCAtNzQsNyArNzQsNiBAQA0KPiA+ID4gPj4+ICAj
ZGVmaW5lIFJDQU5GRF9HU1RTX0dOT1BNICAgICAgICAgICAgICAgIChCSVQoMCkgfCBCSVQoMSkg
fCBCSVQoMikgfCBCSVQoMykpDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiAgLyogUlNDRkRuQ0ZER0VS
RkwgLyBSU0NGRG5HRVJGTCAqLw0KPiA+ID4gPj4+IC0jZGVmaW5lIFJDQU5GRF9HRVJGTF9FRUYw
XzcgICAgICAgICAgICAgIEdFTk1BU0soMjMsIDE2KQ0KPiA+ID4gPj4+ICAjZGVmaW5lIFJDQU5G
RF9HRVJGTF9FRUYoY2gpICAgICAgICAgICAgIEJJVCgxNiArIChjaCkpDQo+ID4gPiA+Pj4gICNk
ZWZpbmUgUkNBTkZEX0dFUkZMX0NNUE9GICAgICAgICAgICAgICAgQklUKDMpICAvKiBDQU4gRkQg
b25seSAqLw0KPiA+ID4gPj4+ICAjZGVmaW5lIFJDQU5GRF9HRVJGTF9USExFUyAgICAgICAgICAg
ICAgIEJJVCgyKQ0KPiA+ID4gPj4+IEBAIC04Miw5ICs4MSw3IEBADQo+ID4gPiA+Pj4gICNkZWZp
bmUgUkNBTkZEX0dFUkZMX0RFRiAgICAgICAgIEJJVCgwKQ0KPiA+ID4gPj4+DQo+ID4gPiA+Pj4g
ICNkZWZpbmUgUkNBTkZEX0dFUkZMX0VSUihncHJpdiwgeCkgXA0KPiA+ID4gPj4+IC0gKCh4KSAm
IChyZWdfZ2VuNChncHJpdiwgUkNBTkZEX0dFUkZMX0VFRjBfNywgXA0KPiA+ID4gPj4+IC0gICAg
ICAgICAgICAgICAgICBSQ0FORkRfR0VSRkxfRUVGKDApIHwgUkNBTkZEX0dFUkZMX0VFRigxKSkg
fCBcDQo+ID4gPiA+Pj4gLSAgICAgICAgIFJDQU5GRF9HRVJGTF9NRVMgfCBcDQo+ID4gPiA+Pj4g
KyAoKHgpICYgKChncHJpdi0+Y2hhbm5lbHNfbWFzayA8PCAxNikgfCBSQ0FORkRfR0VSRkxfTUVT
IHwgXA0KPiA+ID4gPj4NCj4gPiA+ID4+IFRoZSBwcmV2aW91cyBSQ0FORkRfR0VSRkxfRUVGMF83
IG1hY3JvIGRvY3VtZW50ZWQgdGhhdCB0aGUNCj4gPiA+ID4+IHJlZ2lzdGVyIHdhcyBmcm9tIGJp
dCBpbmRleCAxNiB0byBiaXQgaW5kZXggMjMuIEhlcmUsIHdlIGxvb3NlIHRoaXMgcGllY2Ugb2Yg
aW5mb3JtYXRpb24uDQo+ID4gPiA+Pg0KPiA+ID4gPj4gV2hhdCBhYm91dDoNCj4gPiA+ID4+DQo+
ID4gPiA+PiAgICBGSUVMRF9QUkVQKFJDQU5GRF9HRVJGTF9FRUYwXzcsIGdwcml2LT5jaGFubmVs
c19tYXNrKQ0KPiA+ID4gPg0KPiA+ID4gPiBGb3IgYWxsIFNvQ3MsIEVDQyBFcnJvciBmbGFnIGZv
ciBDaGFubmVsIHggKGEuay5hLiBFRUZ4KSBzdGFydHMgZnJvbSBCSVQgcG9zaXRpb24gMTYuDQo+
ID4gPiA+DQo+ID4gPiA+IEJ5IHVzaW5nIGdwcml2LT5jaGFubmVsc19tYXNrLCB3ZSBhbGxvdyBv
bmx5IGVuYWJsZWQgY2hhbm5lbHMgYW5kDQo+ID4gPiA+IDw8DQo+ID4gPiA+IDE2IHNheXMgaXQg
aXMgZnJvbSBCaXQgcG9zaXRpb24gMTYuDQo+ID4gPg0KPiA+ID4gWWVzLCBpdCBzdGFydHMgYXQg
Yml0IDE2LCBidXQgYXQgd2hpY2ggYml0IGRvZXMgaXQgZW5kPw0KPiA+ID4NCj4gPiA+IFRoZSBH
RU5NQVNLKCkgaGVscHMgdG8gZG9jdW1lbnQgdGhlIHJlZ2lzdGVyIG5hbWVzLiBPZiBjb3Vyc2Ug
aXMNCj4gPiA+IHdvcmtzIGlmIHlvdSByZXBsYWNlIHRoZSBGSUVMRF9QUkVQIHdpdGggYSBsZWZ0
IHNoaWZ0LCBidXQgeW91IGFyZQ0KPiA+ID4gcmVwbGFjaW5nIHNvbWUgbWVhbmluZ2Z1bCBpbmZv
cm1hdGlvbiBhYm91dCB0aGUgcmVnaXN0ZXIgbmFtZSwNCj4gPiA+IHJlZ2lzdGVyIHN0YXJ0IGJp
dCBhbmQgZW5kIGJpdCBieSBqdXN0IGEgc3RhcnQgYml0IHZhbHVlLiBTZWU/IFlvdSBqdXN0IGxv
c3QgdGhlIHJlZ2lzdGVyIG5hbWUgYW5kDQo+IGVuZCBiaXQgaW5mby4NCj4gPiA+DQo+ID4gPiBG
SUVMRF9QUkVQKCkgaXMgbm90IG9ubHkgYWJvdXQgZG9pbmcgdGhlIGNvcnJlY3Qgc2hpZnQgYnV0
IGFsc28NCj4gPiA+IGFib3V0IGRvY3VtZW50aW5nIHRoYXQgeW91IGFyZSBwdXR0aW5nIHRoZSB2
YWx1ZSBpbnRvIGEgc3BlY2lmaWMgcmVnaXN0ZXIuDQo+ID4gPg0KPiA+ID4gV2hlbiByZWFkaW5n
Og0KPiA+ID4NCj4gPiA+ICAgRklFTERfUFJFUChSQ0FORkRfR0VSRkxfRUVGMF83LCBncHJpdi0+
Y2hhbm5lbHNfbWFzaykNCj4gPiA+DQo+ID4gPiBJIGltbWVkaWF0ZWx5IHVuZGVyc3RhbmQgdGhh
dCB5b3UgYXJlIHB1dHRpbmcgdGhlDQo+ID4gPiBncHJpdi0+Y2hhbm5lbHNfbWFzayB2YWx1ZSBp
bnRvIHRoZSBHRVJGTF9FRUYwXzcgcmVnaXN0ZXIgYW5kIEkgY2FuIGxvb2sgYXQgdGhlIGRhdGFz
aGVldCBmb3INCj4gZGV0YWlscyBhYm91dCB0aGF0IEdFUkZMX0VFRjBfNyBpZiBJIHdhbnQgdG8u
DQo+ID4NCj4gPiBHZW40IGhhcyA4IGNoYW5uZWxzIChHRU5NQVNLKDE2LCAyMykNCj4gPiBHM0Ug
aGFzIDYgY2hhbm5lbHMgIChHRU5NQVNLKDE2LCAyMSkNCj4gPiBWNE0gaGFzIDQgY2hhbm5lbHMg
IChHRU5NQVNLKDE2LCAxOSkNCj4gPiBWM0hfMiBoYXMgMyBjaGFubmVscyAoR0VOTUFTSygxNiwx
OCkNCj4gPiBBbGwgb3RoZXIgU29DcyBoYXMgMiBjaGFubmVscyAoR0VOTUFTSygxNiwxNykNCj4g
Pg0KPiA+IFNvIHlvdSBtZWFuLCBJIHNob3VsZCByZXBsYWNlIFJDQU5GRF9HRVJGTF9FRUYwXzcg
d2l0aCBhDQo+ID4NCj4gPiBHZW5lcmljIG9uZSBSQ0FORkRfR0VSRkxfRUVGKHgpIEdFTk1BU0so
MTYsIDE2ICsgKHgpIC0gMSkgdG8gaGFuZGxlDQo+ID4gdGhpcyBkaWZmZXJlbmNlcw0KPiA+DQo+
ID4gV2hlcmUgeCBpcyB0aGUgbnVtYmVyIG9mIHN1cHBvcnRlZCBjaGFubmVscyhpbmZvLT5tYXhf
Y2hhbm5lbHMpDQo+ID4NCj4gPiBhbmQgdGhlbiB1c2UNCj4gPg0KPiA+IEZJRUxEX1BSRVAoUkNB
TkZEX0dFUkZMX0VFRih4KSwgZ3ByaXYtPmNoYW5uZWxzX21hc2spDQo+IA0KPiBKdXN0IHVzZQ0K
PiANCj4gICAgICNkZWZpbmUgUkNBTkZEX0dFUkZMX0VFRiAgICBHRU5NQVNLKDIzLCAxNikNCj4g
DQo+IGFuZA0KPiANCj4gICAgIEZJRUxEX1BSRVAoUkNBTkZEX0dFUkZMX0VFRiwgZ3ByaXYtPmNo
YW5uZWxzX21hc2spDQo+IA0KPiBBcyBjaGFubmVsc19tYXNrIGNhbiBuZXZlciBoYXZlIGJpdHMg
c2V0IGZvciBub24tZXhpc3RpbmcgY2hhbm5lbHMsIGFsbCByZXNlcnZlZCBiaXRzIGFib3ZlIEVF
RiBpbiB0aGUNCj4gR0VSRkwgcmVnaXN0ZXIgd2lsbCBiZSB6ZXJvLg0KDQpBZ3JlZWQuIFdpbGwg
YWRkIHRoaXMgY2hhbmdlIGluIG5leHQgdmVyc2lvbi4NCg0KQ2hlZXJzLA0KQmlqdQ0K

