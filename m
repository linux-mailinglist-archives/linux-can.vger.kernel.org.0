Return-Path: <linux-can+bounces-3255-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47B2A746A3
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC7317B911
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0896211297;
	Fri, 28 Mar 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kdk4KDbv"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010056.outbound.protection.outlook.com [52.101.228.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D01940A2;
	Fri, 28 Mar 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743155512; cv=fail; b=W3IWlawkj0D/poV4YZiL1cKzlH1/eWqewTfs9xjR24N8Nn5WY+B8zDy/vscq9ZobvFWzTJXGh9y32WWG3z5uNSCWSHidUkwdubDftLGw1J/njaweEQlxJgrbeFpcRVAwIeowWas02mOyNV0LrRLRAOY6qz0Y3fyAv1rJp4XMv80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743155512; c=relaxed/simple;
	bh=XpvKqSlWPkLJCkKkU2CDNC0XhxDlf6iNTlMfSfj4AWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mzW8JwjvpvqK1RnRTa9GfAkx8vbczeypc3kt5k74wkLyUsiPOp9QydaLXuMWTl/hvTjz/N/lutwWF7R1R9dQXH36xPgXLHtNAmrjdFVmvG4s7x+x86b0G8Gzq1rO92VIw+9n8jywcszUdx2svj4GJcKs7oSR3hMEvwqsphVuel8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kdk4KDbv; arc=fail smtp.client-ip=52.101.228.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB2IW5i5rglqDrZVO2nQVvqJxoyPlngegTD6K9dmYHCo7wd+D9hmNDdfvYlE0exXH2VnJNzyUwylQEKQTjYzeiNvSDbYimd1kdHO/GjnEoFAQIFlWxppWshcMuG0TYZY0Ak5ZjVTKcgNNVlhBPIzc/27t21bLiKwRoR7p5ZTILhF8JkAe3qtBpa7fXYt0jhIkDFVbkWYUeDcDIFbYFWHhwQ1mqvh07j6EcBmGWAlcoTJnTmW4eXwCx1xOOJ3BjN8hZFVDBJD/xgWLuV5EAugo+/GOyG9y7afagGjWY5h3O2G6i5e5mDcoZr2U6UbzEi4my+eEMzxZrbVu6vJzJ5cGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpvKqSlWPkLJCkKkU2CDNC0XhxDlf6iNTlMfSfj4AWY=;
 b=ieSYBXnOGhTQH3kwHPrYqw1WCyBrHMydNW/vBrccObpzvTyExwflmxk1iILiyklv5Rcm4ciyIakecvoa1byL/uYEzLWayePyxOL70KB+R9bioMSd/n4WCgcFgE7ggoWucTxNaagDbPucdODIOBoRF14ibOL1W82ZRk+4QbAs1E1sVMZL6NP7udoWPZlmIX7lb+arLcNFuy7o86cuIhRBbZn/dPjlpiG1slfrxyVG/R4fLra2SabWqDv0O4emEBzCuS2PnLQv5P2LifCTZnn54clCUZq4PEIiYvB+rivZ60h1OzEHGBnJV0PPlrnY8M0JqjuOER4ogqgobFAC0JRwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpvKqSlWPkLJCkKkU2CDNC0XhxDlf6iNTlMfSfj4AWY=;
 b=kdk4KDbvnQFojpiFvoskcwRKSIymjG5QCzQxUo/1lZJDs/De7O+5wV7YbYDRPkRDAeZG4/nW/g8C/u6tZ5474x2CWY0Xre81lOAKIFgtlOBnv+ZxBwh8tBJ39IW/fYBxbcZtQZ/ny1gFudeYHsWLseTg8IxiDsCqPeVmjmT7WN8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8617.jpnprd01.prod.outlook.com (2603:1096:604:19d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 09:51:43 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 09:51:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde
	<mkl@pengutronix.de>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Thread-Topic: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
Thread-Index: AQHbnkl63JoFqVndWE+hQB80zsNhELOIReiAgAAAqiCAAAbcgIAAAW/w
Date: Fri, 28 Mar 2025 09:51:43 +0000
Message-ID:
 <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
 <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
In-Reply-To: <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8617:EE_
x-ms-office365-filtering-correlation-id: b2372c19-6d75-40dd-3a6c-08dd6dde2585
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlFsRXMxV3RzRTJYdldSb0xkTHIyMGNVSEEvZHUyY0VoNnY5SzJpYm9tZlhE?=
 =?utf-8?B?YXRFVWE1TkYxZ2VmU1Mrb2hSSndSaEx0N3ZMalVoY3NwQVpIOGJRZmhheHdM?=
 =?utf-8?B?WTRCS3NMdjY3UFlxYWhLVkxQRFJTSFlaOXpkeDZ0TXRVYUtxNVRmb0VSOFZE?=
 =?utf-8?B?cmg3WXpKY0p6ZVc1VExDdkoxZlhZMEVRNk9qa3B3NG5OOFlWOFJpQnBrOEhF?=
 =?utf-8?B?aFZJOUNKcU5QRVJrTGxxK04xY3pwSUVwV2Y1NEdVVmVldmpwZVZ1TldiVERD?=
 =?utf-8?B?cUZmN05BcGdxeGRxUUFSajliN0ZBQ0QwTFFiYW8vVE9ITU9zaDlORVUrcUNZ?=
 =?utf-8?B?eDgyaTVVcjlmTFpaV3BIdU9UNkVKT2VnZWY5bXBuTVBkR1Zka011cnVZVGdL?=
 =?utf-8?B?QU1ac1JiMDRFb214YW5sOTdaTVluNDlrZG5rQ2RvZm5hdnA4N0NwVmJzVUtR?=
 =?utf-8?B?bUxSUEQxa0VYU2o3QjVGcU5NbG1XTXNGNS81N21iRVZ1WTB2bnNGNnp4U2pw?=
 =?utf-8?B?ZXNXSG1JYlF1WElpMUVtR3BkeFRvYThXWUppTE1TS0tUdnlOQXo4ck9Ed3hS?=
 =?utf-8?B?c3liMzFPc3VISEJ0ZnRwaDVEbko5MnBCV3dWSG1CYWRVSWtSZ28vUEZ5RW9V?=
 =?utf-8?B?c3ArVTF3bFRFODdDdlBUUXBmeG5mcUlXWVhvRnc1RHZtTjZPYWtqc1RXVGEw?=
 =?utf-8?B?N1ZyYUl4T3lsVkREK1ppa2FseGpkenArcmNZSVVXV0pnVm0vRGxTODJTNFN5?=
 =?utf-8?B?ZWI0NFBHUWl0NUlpOUVWdTVkaEJlMTNJU2RDVXN6TTJiU0s1cHFlc0hHSUJX?=
 =?utf-8?B?M2R0NWl4NnBkQm1iQkZXcS9VUkd1NEhtRFhUR1JCZGdnY01YSkppNVhNY2NM?=
 =?utf-8?B?YjNHNkVwSTdKUm9mS1pLd090V3VETW1hM0d5TlhMY0JFZzZnd3FkZjY2dVVi?=
 =?utf-8?B?ZE5vRnpkYklmL0RZNUtlcTJmMXBmdGMyWktFQ3lDdnlvQUVNNDVNYzdlMGY1?=
 =?utf-8?B?d0huQk11N1NNTU9iekFZQ09CUnNDNVNXTnliTitkRHlSVlVIais4WE1aM2t5?=
 =?utf-8?B?RCt5RFJIdWhlemN6N3RjbERWTGZKOU84eEREdUVaVUV6aG9UK3FZeHdMUStI?=
 =?utf-8?B?ZDAvRWlqZlorWlU5TUlxR2RMRG14Snc1MUZuZ2xhSVk0OHByZ1NmZWNWVEZv?=
 =?utf-8?B?QU5NTW5XK1JJZTBOVFQvTmgzeVpEZHhOSXZydE1sK29TaVpDaVJiMmJ5Qm9R?=
 =?utf-8?B?cjhYU0xWNDNlVDVrNWtVRE1rQVMzL0Fra1ROTEwrUFhDaXJxdFZ5SUYrY0xn?=
 =?utf-8?B?SHNmZ2hudjY4M2E1THBkNWhLbTBmNnNKaDFxcHpyVll3dlFhT0VyYTNtRlhU?=
 =?utf-8?B?Mmh3a1BTSFhCZVFnZ3RrakNlbHp2OSt1cXEvdVR0VGx1YzBJR0oyMEtYUmZl?=
 =?utf-8?B?QXJocUdRRVp2VlB0RlBVMCtld0F0b1Vxd3dGWVBKUkE5VEUxdXRyWG5vNWIw?=
 =?utf-8?B?VmMxQ3VaSU5yTk5XN2xOZXFBd211WlA5Wjhva202V0FJckJ0MG55NXdrRjhm?=
 =?utf-8?B?dnpyOGMwMGNHUWZnODd2aUFSYlBMQUNLWlZaVVZoZ0NjS1R2cFJsY0svRXhJ?=
 =?utf-8?B?aklzK0pQZ0RtVC9QVnFrRUQrNGZtQVJJWHRJM0w4Y3RqQkJQUWtxT0NBV3JQ?=
 =?utf-8?B?Wi9EejZFUVlGeXFqZTl6MzJ5V3oxb0RJYjhYMkZOVTlBV3MwUnhHZUVXU0l4?=
 =?utf-8?B?RE1PazY2eWpyTEVLMm5iNUdZTjJKekdYdkNtUjI0OHBjK3J5WWpKTHAwcXJJ?=
 =?utf-8?B?L0ptL1hhbEM3TlRoMnNVOTZmWjV4dzF4SmFscFI1VzFoc0J2cWVaWDBnZ3Ja?=
 =?utf-8?B?aUJaL0ZtcjhXSDZCTVdZZGVpWTBaR3M2N1dPam9jWXlhUkZXdXRLZWFvd0Jn?=
 =?utf-8?Q?/lagxqeY6AVTa3ezEvkATNaYfsf6wT67?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UThmS3krWWdOdUwyS0FwOXBuT0sva1ROdm12bndMN1RzOWNrQkJyTUh6SlI5?=
 =?utf-8?B?SFhLaDcrdlBic0JuRE9OdFlVbnJZa01vUHRacXBSMWt1a3JXb0xpbG1LSlVv?=
 =?utf-8?B?NE1McmxRMWt3bHNWcWRoRzh6ZjdSS3lpUWNGblVHeGN0dWFTdnFvcXQwZlN6?=
 =?utf-8?B?MENGSFdLYjNKSU8zV0xSaWd1OE0vT3BMMnRDb0hMZDRBSFpacUJYTXVEQWFi?=
 =?utf-8?B?RVhZb1Fudk95WEMwY1JRNWxWeUVQZDdxY1d5RWE1dFpyMFVSNVBac0I5WXlY?=
 =?utf-8?B?ZzhRMnprb0ZMNURMcUJxdlJ0eURLRDdVUXR0amQ5RHpMTEMrNjNockpJbk43?=
 =?utf-8?B?eFFGUURpc2FJT3ZFM2NSZERJRFJGM2ZnbElSZlcyUlNacEpUVUdxQS9IZHgy?=
 =?utf-8?B?NXB5V3RFSU9QUXh4MFJsSFFuZzdBckdncWtnaGtPSmhnOFQ4bUwzaUJxRHdU?=
 =?utf-8?B?eEdyYkY3b0loTGZVZXhmY0FpM25MUVQ1UFMwd1ZnaDBzZXhmUzd0a0UvdnpZ?=
 =?utf-8?B?RVBUd0pmMk5oWTNFWXF0QnBZZHB4VXlIekZDWElRTWNrV2hQdDRCUE1uMHVK?=
 =?utf-8?B?a1A2S2R3Wml6SFFSUU9tVTU5eGQ2UTdrb2Z5cnhEM3ZaU2pqeHRHSnFFU042?=
 =?utf-8?B?U0l6SXJFaGZnQnhEUHk0RGhrdlBySm0xbklMYlczUDJiUmtiYXNwWEMxVjZW?=
 =?utf-8?B?UStQOE90c0lTaytPMXRBYjhHUWxQUm1GbXgzcWFWODZIQUdrb01UY0o4L2hE?=
 =?utf-8?B?eXZiY3kxRjNJWkw2Szh0MEEwY1dVNUxTSkFOQ1pvNUZGdXNibE5MM2dESWJk?=
 =?utf-8?B?RkYwWm4zYTFPREl1WkF3R1Q0Q1QxVXRTY2thdkRwZ2VSV2RGTFQzY29sUllH?=
 =?utf-8?B?ZjZEMlp1dk91N3d1K2VkSEN4NU5BTWtjMUtqRkorY2ZKa0U4ZEoyenFPdUda?=
 =?utf-8?B?YnNpWHhKR0t3cnE5NXNvK2tMcTFXSk1HV1JPYVhDQlA2R1hWQWl6S1gzYkdE?=
 =?utf-8?B?N2hOc1ZvVHErcysyODRnWFFrYktIMTBkMS9nc01XWHdRVVhuV01zbytUZEdz?=
 =?utf-8?B?VW5QT0lCMk9pV1dWRzJ4YnBKbkRqbGlXN01Cc2xBTUlFTzZ2UlVRclZvY0Jk?=
 =?utf-8?B?eWJFUHVDU3NWYXZ2ZnNFZmhsd1BQTGYrRmkwdEMzRE0rSGpUdUVWeW1jZjBB?=
 =?utf-8?B?RGxuUlM5TmR3cHdtaWNhcjN1RWtOTTdmRjYySE5PbjhqZ3lpdkVKSGdPRkFQ?=
 =?utf-8?B?L3U5aDZXM2ZmTlJTZ1dkZHI4QVpSNTZrMWxLMjZvbkRWOXNFZkJRWkQ3eGZX?=
 =?utf-8?B?aUlmQ3hWMjBKaEdUSGZVNWc5KzRzSGJkWkwzTDJjZU55cWRJd1l6OVpUNTgz?=
 =?utf-8?B?Mk9RbWJaUW9NTnRwRTV1bTFzNERJUVlCNnFJSDBoUGt5ZmF2a0RDN0xQam55?=
 =?utf-8?B?d01uQmVBbzI0L0ZOUE11dVZFejNvN2VVWDV4Z3lGNDhMSXJqQ0hhTGJha0Nn?=
 =?utf-8?B?akNWMWJ1b1lxWWRFdHBpanpzUk9iL0R4L3duQzZMQ044YmlFbFZrdmpmSWcz?=
 =?utf-8?B?eHZxTVptUXE2TXdmaXVxVzZMKzRURmtwWmVmTzBjR21VaGwvU1NnRElET0Zp?=
 =?utf-8?B?ZllmUHJQc1NaOE1IcmZNNjNyS3I2cHI4ZHN4bHV3azFzNE5jdXpGODVLYmI4?=
 =?utf-8?B?M1pnU2Q2WW8zK0FOeGVFMlVHaTNpK3hCUkRxYkh1cnJMVXR5WWxPUC81THl1?=
 =?utf-8?B?cXg4QjlIVWpRQ3BEZ1FnUDFINEl0UFFuMk1tUGFwelVtdnppYmlORDZrditO?=
 =?utf-8?B?NzMxN0hocVM0ajZpRUMvbk9TTjR1TkJJRUFWeFlQUGYwODZqWUJYdjNTbkx0?=
 =?utf-8?B?NXBIc1BybEk1Zm1yMENIODZ1ekFtQi9vSkE3d0pFaVp1aDFWRlV2QldJUU4y?=
 =?utf-8?B?MTBreFNmQlZFWFc2K3p1T1l5eEtjS2ZsYTJwMmxuTjd3bGZkYitjRkZ2N1pH?=
 =?utf-8?B?eER1dTc2TnRyVlVKSkFkcE9YM0hTeEFmZm1jb1FrMkRLVVBaekV4RkZsdjJz?=
 =?utf-8?B?RkljK1pBYklGbVRPc0Y0SFVzMWlXWWxCVit5QTFlQ1V4UVN6K3Q2V3QzcGZI?=
 =?utf-8?B?aTcyYXd1cVZqK0IwbDl3ZWlqWURMbW1LVE5BS1RTVFpHVmk3QnJNaUJYeGVh?=
 =?utf-8?B?VVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2372c19-6d75-40dd-3a6c-08dd6dde2585
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 09:51:43.5691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeNaNBrfm73hmx6KMWHUiQYHJLduAjyzRi/up9NftY3fftBmetJYs0CRCwQp1y4CdUaSsEDaysoi//BdUzXtukysWZIgpDFgo4BTyuGbRaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8617

SGkgVmluY2VudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5j
ZW50IE1haWxob2wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyOCBNYXJj
aCAyMDI1IDA5OjM3DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDUvMThdIGNhbjogcmNhcl9j
YW5mZDogRHJvcCBSQ0FORkRfR0VSRkxfRUVGKiBtYWNyb3MgaW4gUkNBTkZEX0dFUkZMX0VSUg0K
PiANCj4gT24gMjgvMDMvMjAyNSBhdCAxODoyMSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgVmlu
Y2VudCwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhv
bC52aW5jZW50QHdhbmFkb28uZnI+DQo+ID4+IFNlbnQ6IDI4IE1hcmNoIDIwMjUgMDk6MTANCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwNS8xOF0gY2FuOiByY2FyX2NhbmZkOiBEcm9wIFJD
QU5GRF9HRVJGTF9FRUYqDQo+ID4+IG1hY3JvcyBpbiBSQ0FORkRfR0VSRkxfRVJSDQo+ID4+DQo+
ID4+IE9uIDI2LzAzLzIwMjUgw6AgMjE6MTksIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4gVGhlIG1h
Y3JvcyBSQ0FORkRfR0VSRkxfRUVGKiBpbiBSQ0FORkRfR0VSRkxfRVJSIGNhbiBiZSByZXBsYWNl
ZCBieQ0KPiA+Pj4gZ3ByaXYtPmNoYW5uZWxzX21hc2sgPDwgMTYuDQo+ID4+Pg0KPiA+Pj4gQWZ0
ZXIgdGhpcyBkcm9wIHRoZSBtYWNybyBSQ0FORkRfR0VSRkxfRUVGMF83IGFzIGl0IGlzIHVudXNl
ZC4NCj4gPj4+DQo+ID4+PiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCty
ZW5lc2FzQGdsaWRlci5iZT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gdjYtPnY3Og0KPiA+Pj4gICog
Tm8gY2hhbmdlLg0KPiA+Pj4gdjUtPnY2Og0KPiA+Pj4gICogQ29sbGVjdGVkIHRhZy4NCj4gPj4+
IHY1Og0KPiA+Pj4gICogTmV3IHBhdGNoLg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9uZXQv
Y2FuL3JjYXIvcmNhcl9jYW5mZC5jIHwgNSArLS0tLQ0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4+PiBiL2RyaXZlcnMvbmV0L2Nh
bi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+Pj4gaW5kZXggNTY1YTkxYzJjYTgzLi5hOWU5NjJhMTUx
MGUgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMN
Cj4gPj4+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+Pj4gQEAg
LTc0LDcgKzc0LDYgQEANCj4gPj4+ICAjZGVmaW5lIFJDQU5GRF9HU1RTX0dOT1BNCQkoQklUKDAp
IHwgQklUKDEpIHwgQklUKDIpIHwgQklUKDMpKQ0KPiA+Pj4NCj4gPj4+ICAvKiBSU0NGRG5DRkRH
RVJGTCAvIFJTQ0ZEbkdFUkZMICovDQo+ID4+PiAtI2RlZmluZSBSQ0FORkRfR0VSRkxfRUVGMF83
CQlHRU5NQVNLKDIzLCAxNikNCj4gPj4+ICAjZGVmaW5lIFJDQU5GRF9HRVJGTF9FRUYoY2gpCQlC
SVQoMTYgKyAoY2gpKQ0KPiA+Pj4gICNkZWZpbmUgUkNBTkZEX0dFUkZMX0NNUE9GCQlCSVQoMykJ
LyogQ0FOIEZEIG9ubHkgKi8NCj4gPj4+ICAjZGVmaW5lIFJDQU5GRF9HRVJGTF9USExFUwkJQklU
KDIpDQo+ID4+PiBAQCAtODIsOSArODEsNyBAQA0KPiA+Pj4gICNkZWZpbmUgUkNBTkZEX0dFUkZM
X0RFRgkJQklUKDApDQo+ID4+Pg0KPiA+Pj4gICNkZWZpbmUgUkNBTkZEX0dFUkZMX0VSUihncHJp
diwgeCkgXA0KPiA+Pj4gLQkoKHgpICYgKHJlZ19nZW40KGdwcml2LCBSQ0FORkRfR0VSRkxfRUVG
MF83LCBcDQo+ID4+PiAtCQkJIFJDQU5GRF9HRVJGTF9FRUYoMCkgfCBSQ0FORkRfR0VSRkxfRUVG
KDEpKSB8IFwNCj4gPj4+IC0JCVJDQU5GRF9HRVJGTF9NRVMgfCBcDQo+ID4+PiArCSgoeCkgJiAo
KGdwcml2LT5jaGFubmVsc19tYXNrIDw8IDE2KSB8IFJDQU5GRF9HRVJGTF9NRVMgfCBcDQo+ID4+
DQo+ID4+IFRoZSBwcmV2aW91cyBSQ0FORkRfR0VSRkxfRUVGMF83IG1hY3JvIGRvY3VtZW50ZWQg
dGhhdCB0aGUgcmVnaXN0ZXINCj4gPj4gd2FzIGZyb20gYml0IGluZGV4IDE2IHRvIGJpdCBpbmRl
eCAyMy4gSGVyZSwgd2UgbG9vc2UgdGhpcyBwaWVjZSBvZiBpbmZvcm1hdGlvbi4NCj4gPj4NCj4g
Pj4gV2hhdCBhYm91dDoNCj4gPj4NCj4gPj4gCUZJRUxEX1BSRVAoUkNBTkZEX0dFUkZMX0VFRjBf
NywgZ3ByaXYtPmNoYW5uZWxzX21hc2spDQo+ID4NCj4gPiBGb3IgYWxsIFNvQ3MsIEVDQyBFcnJv
ciBmbGFnIGZvciBDaGFubmVsIHggKGEuay5hLiBFRUZ4KSBzdGFydHMgZnJvbSBCSVQgcG9zaXRp
b24gMTYuDQo+ID4NCj4gPiBCeSB1c2luZyBncHJpdi0+Y2hhbm5lbHNfbWFzaywgd2UgYWxsb3cg
b25seSBlbmFibGVkIGNoYW5uZWxzIGFuZCA8PA0KPiA+IDE2IHNheXMgaXQgaXMgZnJvbSBCaXQg
cG9zaXRpb24gMTYuDQo+IA0KPiBZZXMsIGl0IHN0YXJ0cyBhdCBiaXQgMTYsIGJ1dCBhdCB3aGlj
aCBiaXQgZG9lcyBpdCBlbmQ/DQo+IA0KPiBUaGUgR0VOTUFTSygpIGhlbHBzIHRvIGRvY3VtZW50
IHRoZSByZWdpc3RlciBuYW1lcy4gT2YgY291cnNlIGlzIHdvcmtzIGlmIHlvdSByZXBsYWNlIHRo
ZSBGSUVMRF9QUkVQDQo+IHdpdGggYSBsZWZ0IHNoaWZ0LCBidXQgeW91IGFyZSByZXBsYWNpbmcg
c29tZSBtZWFuaW5nZnVsIGluZm9ybWF0aW9uIGFib3V0IHRoZSByZWdpc3RlciBuYW1lLCByZWdp
c3Rlcg0KPiBzdGFydCBiaXQgYW5kIGVuZCBiaXQgYnkganVzdCBhIHN0YXJ0IGJpdCB2YWx1ZS4g
U2VlPyBZb3UganVzdCBsb3N0IHRoZSByZWdpc3RlciBuYW1lIGFuZCBlbmQgYml0DQo+IGluZm8u
DQo+IA0KPiBGSUVMRF9QUkVQKCkgaXMgbm90IG9ubHkgYWJvdXQgZG9pbmcgdGhlIGNvcnJlY3Qg
c2hpZnQgYnV0IGFsc28gYWJvdXQgZG9jdW1lbnRpbmcgdGhhdCB5b3UgYXJlIHB1dHRpbmcNCj4g
dGhlIHZhbHVlIGludG8gYSBzcGVjaWZpYyByZWdpc3Rlci4NCj4gDQo+IFdoZW4gcmVhZGluZzoN
Cj4gDQo+ICAgRklFTERfUFJFUChSQ0FORkRfR0VSRkxfRUVGMF83LCBncHJpdi0+Y2hhbm5lbHNf
bWFzaykNCj4gDQo+IEkgaW1tZWRpYXRlbHkgdW5kZXJzdGFuZCB0aGF0IHlvdSBhcmUgcHV0dGlu
ZyB0aGUgZ3ByaXYtPmNoYW5uZWxzX21hc2sgdmFsdWUgaW50byB0aGUgR0VSRkxfRUVGMF83DQo+
IHJlZ2lzdGVyIGFuZCBJIGNhbiBsb29rIGF0IHRoZSBkYXRhc2hlZXQgZm9yIGRldGFpbHMgYWJv
dXQgdGhhdCBHRVJGTF9FRUYwXzcgaWYgSSB3YW50IHRvLg0KDQpHZW40IGhhcyA4IGNoYW5uZWxz
IChHRU5NQVNLKDE2LCAyMykNCkczRSBoYXMgNiBjaGFubmVscyAgKEdFTk1BU0soMTYsIDIxKQ0K
VjRNIGhhcyA0IGNoYW5uZWxzICAoR0VOTUFTSygxNiwgMTkpDQpWM0hfMiBoYXMgMyBjaGFubmVs
cyAoR0VOTUFTSygxNiwxOCkNCkFsbCBvdGhlciBTb0NzIGhhcyAyIGNoYW5uZWxzIChHRU5NQVNL
KDE2LDE3KQ0KDQpTbyB5b3UgbWVhbiwgSSBzaG91bGQgcmVwbGFjZSBSQ0FORkRfR0VSRkxfRUVG
MF83IHdpdGggYQ0KDQpHZW5lcmljIG9uZSBSQ0FORkRfR0VSRkxfRUVGKHgpIEdFTk1BU0soMTYs
IDE2ICsgKHgpIC0gMSkgdG8gaGFuZGxlDQp0aGlzIGRpZmZlcmVuY2VzDQoNCldoZXJlIHggaXMg
dGhlIG51bWJlciBvZiBzdXBwb3J0ZWQgY2hhbm5lbHMoaW5mby0+bWF4X2NoYW5uZWxzKQ0KDQph
bmQgdGhlbiB1c2UNCg0KRklFTERfUFJFUChSQ0FORkRfR0VSRkxfRUVGKHgpLCBncHJpdi0+Y2hh
bm5lbHNfbWFzaykNCg0KQ2hlZXJzLA0KQmlqdQ0K

