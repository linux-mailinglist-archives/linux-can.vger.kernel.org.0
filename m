Return-Path: <linux-can+bounces-3096-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACE8A619A2
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 19:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624EF3ABE1B
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0E1F3BAE;
	Fri, 14 Mar 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fEKt3Idm"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011039.outbound.protection.outlook.com [52.101.125.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC881519BB;
	Fri, 14 Mar 2025 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977550; cv=fail; b=iQmJNKebUvBGtl/ufbujV3fuwcEhnoRikVoNeHu7vJ5wdnGU05PrMEAoJd6/oItZN7kjmGSuhJq7vw6LBK5k5WBYRpJVdoh05lD1Z/DKm8cbagcfcDuVKgi32AKILq0cYKQvDRlqwwg+T7/XO+lxpt5ndfGI92b7Yk8/00diytM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977550; c=relaxed/simple;
	bh=Z/+ARvrp/zOddb3/QVWVRis45tmjwcKkks+lrG7ShPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lS0DMPlfFY3po7zdF20eFoHoDZFZSz7Cm4lxluZzsSiYyv38MDqPK5/RazX/R0hGFoaXqbh61I4ngcfBzkOyuwiIU230H5d1T7AkDfOV38LHJeN1LEPpPyRVnjkmNhPCJDcDvNhy3aSHnUYaKrkGexEmw1S7hNA4n7lt2kHUh9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=fEKt3Idm; arc=fail smtp.client-ip=52.101.125.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxmox+llcPIwNGq0HdMiCouCjdHcA2xqLJHa4HDJuUF9XfpWW2YgO6X3/mAtHhcs7HsmIskWxf9XYsgVV4P+IHiQJAx9AUvU69f1tUryDzlFvnFpKeqZjuNqvkbRRpldBsWYOj7TF3w2oJBMg5Zh8zPQPSW1TlSCEgjaQ5S+D2xNNzGUIcui3M0OnKQAsWCRgIAhYeBBi8DDKKOnElXJW+WnIOYJ+EgCyCr7oIJllBf5ZcdLpTKm9PcUH64QmRdsYYGR3XggZUwvDEDljZrexW6jpRhhUqqoQky8XrILOzusTeo9KrkB/OtvuOK4T/n6AdI6q0GcJRRG+ajYD4LO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/+ARvrp/zOddb3/QVWVRis45tmjwcKkks+lrG7ShPk=;
 b=Z46gguBtv8Jac5YvRIxMjtdw3EpVpLUyqSs2yyxuas9+BCqjXgM6RrjRMyp76FMW9n481QMqPu6Daz63suYBLe5zLJ/pnSEnpkGFXmyVP6x+MoslM2xP/HHeX/o4CkSADNg8yFjlJRmII6RJpxIpYPA2rb1ccowJx7koWgbVTGTHboWH7In349ILPEf5GOO4VEvRQpLK4TMFpbFYjDDUrki1S9S8sr+wZG8XWkVFbWh+EiCmsGjt8J/3704TDyrOf3UgWWIPVon6h2X7oajsej3F+Cbqj8sAncJgu3+Dnq6si/b1rbxIcWlBwU5EapHJG1chIU7pI4bW5pMPzeyUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/+ARvrp/zOddb3/QVWVRis45tmjwcKkks+lrG7ShPk=;
 b=fEKt3IdmP7O3zW4H313rYcY4SjgD1/E+p1D9YL3dYA2QZeJVJ4hote1EMMuzixuSadwYje9p6UTERSwgFm7vC4GQpBsgpx562hX0RIWq/TmBMWb676oxcyl1M8NFsuHhF/0HBalL26GzHAg2ifcmJyIBQ6EsjlC7R0YiUBC/wJc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10827.jpnprd01.prod.outlook.com (2603:1096:400:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Fri, 14 Mar
 2025 18:39:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 18:39:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 08/11] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Thread-Topic: [PATCH v4 08/11] can: rcar_canfd: Add shift table to struct
 rcar_canfd_hw_info
Thread-Index: AQHbjpVh5pBDjQAOZU2YFEmYsgBFpbNywusAgAA/8dA=
Date: Fri, 14 Mar 2025 18:39:01 +0000
Message-ID:
 <TY3PR01MB113467B2BB274C1D0782BFF0786D22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-9-biju.das.jz@bp.renesas.com>
 <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10827:EE_
x-ms-office365-filtering-correlation-id: 8091c7de-01dc-4b83-dd9a-08dd63277d42
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1cybldIS0hNK3MwVklnK1llZXZZSnRJbktWQ21FQ3ZyUlBaNzJaU3d0T2p0?=
 =?utf-8?B?cnlwdTErR3AzMjBhTUJEbkZabVZvS0JOazVwa3JSTFZmWmFGNThTUjVYUTVr?=
 =?utf-8?B?ZFVjN1liN1FZWHl6ODZjbmhwR0xVa0Y1djVjZkpLOVhXUmhsZUNTeXJhSkQ2?=
 =?utf-8?B?dXZoL1c5VWJXWEw2ME5ra3hSVVdRajRyN08vOUdKRG9mZXJEN2daV2ltMTZa?=
 =?utf-8?B?RFFlVDJQclpTbERPYVpTVkR6bTVBVzdqVGNvY2hlNjJLYmdEa2JiV2trK3V5?=
 =?utf-8?B?eFJtK1BiVlYwaERsVUlaVXMvSVVGK3JxN0xOOGJWcHhTWXJnV0JtVjZja25Q?=
 =?utf-8?B?WDhoeEExNndjQUk4Z3p2WlFsekc2NUNTc002N3phem9ocHQycVMvM1kwY0FH?=
 =?utf-8?B?Nm5BNWtqOGRNU3FnYUtMV01HN052bEs2NmdrcjZJd0NESGpsWndwazVEUXND?=
 =?utf-8?B?TFBlQVRLTUZBNmxNTHFNaEpLMitTTUxyQTlZOHJVN004Z1IwMHNHSUxCZnps?=
 =?utf-8?B?dDhzQTZuWXgxNFZpWllkd1FONmIyNlhocGZtRGlocHg4VHZJejF2MmFENU1P?=
 =?utf-8?B?MHZwbjdnNEwvcTloNDdTdndlUDFvZ3FEenNiZUhWRGZXVGpOTktmanBvVHpJ?=
 =?utf-8?B?UlovVUFSMUpjc1JCZGVDblZ6L1h1QjIzZm00QWVuREFMcnl4amNXQVMvcEZa?=
 =?utf-8?B?Qjh2VFJReStGR3ZhSW9NOUExbGl0aFJWZTR2YW1aQzN5cHFPc0ZmWjE0RkRJ?=
 =?utf-8?B?TzV5cHZSTUdtMU1tSWJpdzJFWkUycnlrUkhKRnJkdU5jQmRUZWcxNWtIQkdp?=
 =?utf-8?B?RUF6MW1WRGZOZXE5TW9ramVzbm12RllpcDI1VmVQV080WW5hbXNWakkyTmtJ?=
 =?utf-8?B?TTV3MFBFK0ZhVmt6WFNrbnVncGFTZVROb0N0N2p5QzRaMDh2bGxkcUJRMFZz?=
 =?utf-8?B?S0dsa1lTOHlPYXVXbFFoeEpDZElBUkthTVkrUXhxUGhGK21UbmI4MWVvajVL?=
 =?utf-8?B?QTd1NkNrSjBPdmMrRlB5ZVA3QUd4dWtmbm9SZFJubzhwdU1HcFQ2RzEyL2p6?=
 =?utf-8?B?NlNqd1IxRjNidHNTMkRKZ2pHTWZtSHRsbkNxOU9SQm5odG5EL1Q1MzVjbkFi?=
 =?utf-8?B?NkVzZ1B2UHY5bk9IM2ZTT3VGOVYzQmxPeEtNOEwxR2M3S0JtY1pJQWR6WGpy?=
 =?utf-8?B?M3NqRTVLb2ticjJVb0FXcDU1VGR3ZWZlbk4xZWZPVi8veEFjNlVVU2ZkK2xs?=
 =?utf-8?B?Q0hDZml2VWpjK1hlZy9wa2svL2JCNzhyalFiWGhsNVBPOHY0VGJEN3FBeUJK?=
 =?utf-8?B?STRFazdPcGJ2Q1N4S1kxTGM0UHREMitmTW1pQ3laNmFWcjNaWVlXdG16V2F4?=
 =?utf-8?B?VTA0RkRrcWtMMitTQ1NSWDdjZVlBUm9jVmlOZU9hZDJXMXBmaDg5ZkhoQ0lz?=
 =?utf-8?B?QlVNUlpwM0Y3WUY4TWVxeG5qSmlpc0xaUkpkNVVyaGdwYWhaQTFwUGlTOExm?=
 =?utf-8?B?QzE1Y3JRM2xKdGZpcGI1N2tZQmduSUhEQ25jUXl2c2V4S0U4aElQWVRhdzZZ?=
 =?utf-8?B?UUpveU81TnR4SVYxUXE1YzlIdmtONkwzNlpiWDZPU0xlcm5kdTFPN0pIUXdi?=
 =?utf-8?B?Nk1GTzkvbG5IQUtkaENtbVloeHFFeXZtYlFSQm5XRFNtelRUdmtsb1BKRVpN?=
 =?utf-8?B?OSs4dHBYR2ZXVFhITXhnMm9vNzBuVnkrVzZVbW9Pa21OamsxdXNyQmk1ZkV1?=
 =?utf-8?B?NkZBNmVWdjEydWdIaWs2VC82TDhqMVBIUVhDNlMwdTVVUjJ2bnQ5eTMrS1VO?=
 =?utf-8?B?Nzg4eUtRMFVMMzd3M2g4WkdLZEJvNThSYVBLelRrZDJiZUVtT0twdGhkUjNI?=
 =?utf-8?B?eW9NRU1qN1hkRGU0VzZWb09xVWY0VFByL2JJekhDREo0OGtEd0cxK2JXblo0?=
 =?utf-8?Q?kXFEmOBA0cwIHskdksr1yNTpsLUah85B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0l0Z1lYUjBEdUFPZnJuanF3b01aQmEwYkF2eEd2WWh5cHhSa0R0WVZrRlFs?=
 =?utf-8?B?cjZITG1YME1PcHBaREhBM3RMdG92L1JwcnduZi9NdS96WXRrbEtWVVhTS1Vh?=
 =?utf-8?B?ZmZhQk9pSFVSUmxUV1pOUzlUTCt1Q2s4YlRPWmdRa2FrQkF3K3k2TGp4aS8v?=
 =?utf-8?B?R1RFeDNqeEZvTG9PWThTUnlSRjZ3K1FTd3dhRFg3ZURsdnc0djNBNHNHQk1V?=
 =?utf-8?B?cFhtUE92dEpaYThXQy9xNjlmVFB4MnVUR3R1U3RwTm8wWlRpT1ozSzN4QWdT?=
 =?utf-8?B?YWo5NjFobldhWDNUNENNTFZjbTRlRkxod1VxekFVY21JdWhuRURPcXlrODB5?=
 =?utf-8?B?cDBEamlTcGVud2JoeVVGOWFiWlJ4ZXc0TG5LMlJlVDVTQlgvbG90Z0paYjhO?=
 =?utf-8?B?VFNhaFJlVk9vMjVlSzljNVRidmdacFJDdVkzZkFQb1RuSnJZQXE4WmRwTE1s?=
 =?utf-8?B?VFdSby9nb083dTZ2dUh1Wkt3WENlZjU3S0F0MVZjM1dCRkEyT25hZFk4U3lO?=
 =?utf-8?B?UWtzc2ZSei9KMkdyN1Z5UXdWVGNYNDEwLzFNY0xmMVBFdUEvSmgrQ0RDZU9P?=
 =?utf-8?B?VGdzUFZoaFlqMGtJT2gxTzFCUFcxRFVyZkN5akpVMnVYYTdKK205MHJSSm9x?=
 =?utf-8?B?SlNNMitHek91R2c2c2tQaXJMY0ZyOHA4NnpwRndndThRREFjOExJc1JQTU43?=
 =?utf-8?B?TnBtaXVRZzFvalp2cmRmYUM2Z0l3THpscDVkQUxWUGJCRm91SXFZbDNYcCtT?=
 =?utf-8?B?dUNnWDhtZVlmeG01dkYyK012cmU0SGlQRzFweDc4NHhoekM1Rk9WZ1UzOFFH?=
 =?utf-8?B?LzNTSGRXSHlWV1d4MU82bGViQi9adXJ3b0VDem9NckJlOTVZUzU0NHgxVTlk?=
 =?utf-8?B?VFh4ZHBkdFBXckJUVndBT284NzNsR3dGanZYTk84dS80aEF0ZXV0MXkzZGo5?=
 =?utf-8?B?UW9Tb2ZSNkdnaU9YWmUrWTVWZGNKY0hDYi9XM1krVytSRE5vSTl6b3FiaHRX?=
 =?utf-8?B?bmFrK1Y0WkUrMmNDN2p6OXFoOWVDYUVDUGdPOGhuVUpNblVUb1VrSGRKL1k4?=
 =?utf-8?B?OEh3U3NrYmk1YW1KQmRyMS9RV0EvWTduWkRYS1FZNU5Va1VoeU1TM1FHVkg3?=
 =?utf-8?B?amJwRXAwZEErdnRINXpZbkxBeEN4M3Rrb1FSdG1tR1ZXUVVVdEhWUExLMG1M?=
 =?utf-8?B?anRqTExMcS9xMC90MzFIbktFL3pKVFl1Y2k3WW5QMlpjY0tuQXFKcStXYmwz?=
 =?utf-8?B?RTlyY3RES2Fpb3VFVEZtcG1Ic014NHI2SzcxV05OUWR1aHFWczYxclhuZnlH?=
 =?utf-8?B?UHJnNkx5TU5lWFgweWRYRmhGd0NVTjRiQVhZRUxxR3lJdVBkNDNTbG93S0Z0?=
 =?utf-8?B?YnJkc1RpYmMrWHRhbzQ0Q2JyeFd5N3haRzhiZmsyQk41UmVxMXBTUTN0M3Ey?=
 =?utf-8?B?bC9uaStydUxmU29RajRhY3V2MGx0bXJQSUVIMmR6aTZHYnBBWTFGM21wZVdU?=
 =?utf-8?B?ZW4vemc3U1poWVJ4UTE3U2VZUUJ0SkJHUGx5dG1Oa2lSL0laTjBGcC8zZEVa?=
 =?utf-8?B?V0tnVk40em9mcGdmekkyZU53cGtoOE1FVWxFTzNCb0V6ZGgxdjAwbEZ6dGE1?=
 =?utf-8?B?eHVVb2dXRWFxUHJhbk1zS2NKem1NcVdDMlVIa280aE1SNU05NC9OK0Z4aHpj?=
 =?utf-8?B?dzZ5T3RlY2tqdC9mQ1JTNmNPb2szcWxVYkVRTWxrbWpNZlB5Sjc1K01kOGlV?=
 =?utf-8?B?YVVpc2F0RDhTQ012VVo5OGZPdm9YelBVRGFwdEprS1NSdzRlNlA3T3BDQjlu?=
 =?utf-8?B?cXE5VWZNVTJBaTRKS0VRUlR2VXoxcTlOZjV3VDF0QzhlWE9VeDI1QkVEN2tE?=
 =?utf-8?B?ZnJxQUlyVWEzK1UwbUJYdCtyUHJ5bzFXSUlIZXVVY1VISXlQWTU2L20rb3Yr?=
 =?utf-8?B?OHdzcjYyaWZXd3R3WC84aHVZbnN5dFYxVzZkUEhpYnFHL214VG5Oa3h4d0No?=
 =?utf-8?B?dUxoM3lKNGtBMDg0UFpJeEpvU1lNYjg0WXVhSWVON0tIY0xyV1BKQlljeDVt?=
 =?utf-8?B?RnNERGViR0xtcE0wRkk0S3JCNGFRamRsTHArSVJhV242byt0elI1azlyVEJU?=
 =?utf-8?B?SHh2Y2hlNkR6ZlhDYVNnSnAzckpPdEhsTWd2c0luVE9QYktIRlh3SDhQM241?=
 =?utf-8?B?a0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8091c7de-01dc-4b83-dd9a-08dd63277d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 18:39:01.2738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xdg+nR3QfGUg0b3baih9vq0f+ENH8sZVNr3uBT6sbjyg35dROt0ziLFeOOtJSMu+25K7A3SEFMwAor/7HJD9tmPSqLNfDcb1cSrn+77HxNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10827

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjUgMTQ6NDgNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAwOC8xMV0gY2FuOiByY2FyX2NhbmZkOiBBZGQgc2hpZnQgdGFibGUgdG8gc3RydWN0IHJj
YXJfY2FuZmRfaHdfaW5mbw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBw
YXRjaCENCj4gDQo+IE9uIFRodSwgNiBNYXIgMjAyNSBhdCAxMzo0MywgQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBSLUNhciBHZW4zIGFuZCBHZW40IGhh
cyBzb21lIGRpZmZlcmVuY2VzIGluIHRoZSBzaGlmdCBiaXRzLiBBZGQgYQ0KPiANCj4gaGF2ZQ0K
PiANCj4gPiBzaGlmdCB0YWJsZSB0byBoYW5kbGUgdGhlc2UgZGlmZmVyZW5jZXMuIEFmdGVyIHRo
aXMgZHJvcCB0aGUgdW51c2VkDQo+ID4gZnVuY3Rpb25zIHJlZ19nZW40KCkgYW5kIGlzX2dlbjQo
KS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3Jl
bmVzYXNAZ2xpZGVyLmJlPg0KPiANCj4gQSBzdWdnZXN0aW9uIGZvciBpbXByb3ZlbWVudCBiZWxv
dy4NCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gQEAgLTkwLDExICs5
MCwxMyBAQA0KPiA+ICAvKiBSU0NGRG5DRkRHQUZMQ0ZHMCAvIFJTQ0ZEbkdBRkxDRkcwICovICAj
ZGVmaW5lDQo+ID4gUkNBTkZEX0dBRkxDRkdfU0VUUk5DKGdwcml2LCBuLCB4KSBcDQo+ID4gICAg
ICAgICAoKCh4KSAmIChncHJpdiktPmluZm8tPm1hc2tfdGFibGVbUkNBTkZEX1JOQ19NQVNLXSkg
PDwgXA0KPiA+IC0gICAgICAgIChyZWdfZ2VuNChncHJpdiwgMTYsIDI0KSAtICgobikgJiAxKSAq
IHJlZ19nZW40KGdwcml2LCAxNiwgOCkpKQ0KPiA+ICsgICAgICAgICgoZ3ByaXYpLT5pbmZvLT5z
aGlmdF90YWJsZVtSQ0FORkRfRklSU1RfUk5DX1NIXSAtICgobikgJiAxKSAqIFwNCj4gPiArICAg
ICAgICAgKGdwcml2KS0+aW5mby0+c2hpZnRfdGFibGVbUkNBTkZEX1NFQ09ORF9STkNfU0hdKSkN
Cj4gDQo+IEJvdGggc2hpZnRzIGFyZSBkaWN0YXRlZCBieSB0aGUgZmllbGQgd2lkdGg6DQo+ICAg
LSBSLUNhciBHZW40IHBhY2tzIDIgdmFsdWVzIGluIGEgMzItYml0IHdvcmQsIHVzaW5nIGEgZmll
bGQgd2lkdGgNCj4gICAgIG9mIDE2IGJpdHMsDQo+ICAgLSBSLUNhciBHZW4zIHBhY2tzIHVwIHRv
IDQgdmFsdWVzIGluIGEgMzItYml0IHdvcmQsIHVzaW5nIGEgZmllbGQNCj4gICAgIHdpZHRoIG9m
IDggYml0cy4NCj4gVGhlIG9kZCBzcGxpdCBpbiB0d28gc2hpZnRzIGlzIGR1ZSB0byB0aGUgTVNC
LWZpcnN0IG51bWJlcmluZyBvZiB0aGUgZmllbGRzLiAgSGVuY2UgSSB0aGluayBpdCB3b3VsZA0K
PiBiZSBiZXR0ZXIgdG8gdXNlIGEgZmllbGQgd2lkdGggcGFyYW1ldGVyLCBhbmQgZGVyaXZlIHRo
ZSBwcm9wZXIgc2hpZnQgdmFsdWUgZnJvbSB0aGF0IChsaWtlIHlvdSBoYXZlDQo+IGFscmVhZHkg
ZG9uZSBmb3IgSUNVIDstKQ0KDQpXaGF0IGFib3V0ICgoMzIgIC0gKG4gKyAxKSogZmllbGRfd2lk
dGgpID8NCiANCnsyNCwxNiw4fSBmb3IgbiA9IHswLCAxLCAyfQ0KDQpBbmQgDQoNCnsxNiwwfSBm
b3IgbiA9IHswLCAxfQ0KDQpDaGVlcnMsDQpCaWp1DQo=

