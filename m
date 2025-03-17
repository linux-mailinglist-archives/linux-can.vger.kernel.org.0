Return-Path: <linux-can+bounces-3114-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC9A6486E
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 10:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A96B3B521E
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B2E22E40F;
	Mon, 17 Mar 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Q2qJQjIn"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011023.outbound.protection.outlook.com [52.101.125.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31B22E3F3;
	Mon, 17 Mar 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205541; cv=fail; b=gvKLgcw8Vkc9+xcaemEDLyNfOAEJiCfWr1wpaDhBrKuAXFnpCjUv64qV3nvEDVTzbeC7a2ck+4ucXbuMMJGD85JxFwwFKRjZoHKqmJNp6vAzzFQViuB/ixYCUsupKN8oHjmapqqQOKKlNF1VC400k3ALdgTpE4kCICNZbQsevb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205541; c=relaxed/simple;
	bh=FcfbUkTmLTZllBc1059bNY1xx2672nawf2I4rPfSxUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJdMIgW/iefOoAVRC7pOvWOXR+jzKDZMb5OR/i0s/rl7XXm5cKrjBMgiQX9D8XQ0bHribsVnbmFl6ynvod0tkqMX07LJ8ITvRl/XwyWPLV8wKs2mbDAbJn3BwY1a5WH8eWaJIUOd31yYopdULRkqtKx4KtG6SWeq6PHxL1NN2bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Q2qJQjIn; arc=fail smtp.client-ip=52.101.125.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJY4wPy4ZZE7XPYArMgC7Du6aPG4EDTjXBZun9yya1GlUhUq9FRyUD9iMQmdifAoCEZkNsbBJCGtilnp1qNs9Xd1NEDEtUmgjxBshtG0hpVUhcBbu6S6Sg40FfX/nsE0I4VN5h56myMQtLtt9mHWW0eVL/NoqPdLYuk7khABPpuqaf/EdCgy1EXnVuD8jqxQV5lVHvdYiAHtL9P121brOXHKbHYqgfhDg9qQNR8xulXkoo4wXdv+jUusPDUTeztiFK/c5a9Hfg4yUy+Zyhve4F1HRoxc8FLXulPzU0PgrmyO0RtQuNDu2uZSh/C5AUSWaGJxP8/0Tb3Gmor2tHZE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcfbUkTmLTZllBc1059bNY1xx2672nawf2I4rPfSxUU=;
 b=juew2eFi35I0ah3SAbvzcUiZxvw9O0pkvZUvm9hxJ+jFYFA99GpuK+Uw82YBuiphEKoid9tOC8BM7UeR2IK3iLLBli1Q5azCW20jwRLP0nyBzGjXnDJNbuF9WaCOrn2ZTvcG7qMlRUEKbiUM6ElTa1P+U3SU5GTyZFeDKVgpOR5hsU1V2bKxGbzFUZlVHfZG6w7v+wrqFM/kPxhQXcO+BvQXmLSHrGSFFLcziUY5f5gNHbg6wiBFlJNF4NA9+y8bTdpBrPVriTkVE3vem0eyT94yrwDfTZipOhvzXh2SPfOdMgd6+NAyhH0DwnYsZCp1r8OWmm9BuDQMwwd97Sv3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcfbUkTmLTZllBc1059bNY1xx2672nawf2I4rPfSxUU=;
 b=Q2qJQjInvO5AG6PpSOowSMHIAlAlKfOh5aonFpYWqQpYYSA6A0g2IFVnm2z419e7iqaoTTtGae2beiqdrTZ6JaQ82kS2lTTgJIwIs15mmqORG8GNJCzvLJANJvRJe4GmorvDFRzWreDtgcv2TDUkupHGdvFETJsnwKVQbVEeFWo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11270.jpnprd01.prod.outlook.com (2603:1096:400:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:58:52 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.026; Mon, 17 Mar 2025
 09:58:52 +0000
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
Thread-Index:
 AQHbjpVh5pBDjQAOZU2YFEmYsgBFpbNywusAgAG/fpCAARLyAIAAdebAgAEcdYCAAADEsA==
Date: Mon, 17 Mar 2025 09:58:52 +0000
Message-ID:
 <TY3PR01MB113469FA4115E9990BDD525E886DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-9-biju.das.jz@bp.renesas.com>
 <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
 <TY3PR01MB113462D2249AB5B239E8213E286DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdWB0N6a_0yfr-e+M1CTmvDy473x+RSvbi++b+oSHWgp3Q@mail.gmail.com>
 <TY3PR01MB11346DE82F59414FFE322F88286DC2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdVWAvbJ=uO-ebPc+saXbvARRdfR-xiNLxj2Vr+iPHphtw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVWAvbJ=uO-ebPc+saXbvARRdfR-xiNLxj2Vr+iPHphtw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11270:EE_
x-ms-office365-filtering-correlation-id: 7e4aacc6-425f-4aac-8cb7-08dd653a5271
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlkxRG1DOEEvU0FEeGdSeFhMUVQrVGZseHpSbUxjUUR0VUVURTJtcnZXM1hQ?=
 =?utf-8?B?NmlOS3dMVkZUaVA2RXhrNjhQTkZ0elM3Z0pHUitKYUowUGxpbmYvSFYzOGt6?=
 =?utf-8?B?MnpBR0JaS2pKaVBMUzRBZzF6ZXJzU0I0QzNqamZqMWFDb3R1SHZna2ZOSllM?=
 =?utf-8?B?VWt6aU01TDZyK2tVajViUkErbjBWT3J6bU1lR2Y0RE1PT254TTJaZUU0VzhU?=
 =?utf-8?B?VWE3bzcvcVdSSnFzK2s1Q0FXaUc0SHdPQldrS0tRS0ZzdFowUmFhazFHTUNn?=
 =?utf-8?B?R3NBOW9LQjZ6NzluNm9qamluclNCSGV4R3FlSWN6NWo3WWJ2SzV5bm80aHhM?=
 =?utf-8?B?cnRERXlPZVU2VUdnWmZiaGtON3FFcnA1WFdBaGJwMk9nV2FkZmtaeE4yTmdN?=
 =?utf-8?B?UndJN1V1cExsaVRLckkvcWtNTVkzMzltdERqTlJOZnFZLzZtV25xN2ZkRDhl?=
 =?utf-8?B?bWpBZXFDU1JsbFptVFNBc2s4cDZJVG84OHRLejBzNWt3TTNCYnl5eEdQd2wy?=
 =?utf-8?B?V3VOL2dXd3ViN1o0NWdaeTRMNFg2SjhlUnQwV0Y5VzRIOWorR0xRNGtUdDJj?=
 =?utf-8?B?cUk0L0w5UkM2S1BuT1lhZEZGdU15UHFzd3Z4VDdzVGNhc0JzUFJHOWd4cENw?=
 =?utf-8?B?cVA3TDhCQ2ZFamQ2U3FvQTZqcG1rdlVkT0xMckhWTmMwWUNoMkRJTGIrR3V3?=
 =?utf-8?B?dlJUdEl6cGNvRWV1K3VZeHVkbHMxcE9JLzhmTEFBOEtqWHFrbWVEWFJ4SDdB?=
 =?utf-8?B?dnNhSlZ6K3oycW0zTCs4K0phOWZ0WXdOdWFiSnRvYTRCKzZWdXN6cjduNjAx?=
 =?utf-8?B?QmtTaUNFdUZIdUZMWitJTC9rOURMOWVHeGliL2p0U2cyMDc3ZURNQTZHd2Jn?=
 =?utf-8?B?NXNwNmlsYmdqY3hqQjlKWFZjSG9kUklqVDNnM0F4ZWhHd0l3QmQ3N2dZNnFF?=
 =?utf-8?B?djBiNGR3TmtIaTA1UVQ3MUVkS1lFQUJKQlR6dE9saGxlYmpiVWV4QmZOWFkw?=
 =?utf-8?B?VjZKdUprMVFWdVV2dk45SmFzNTRzWHNRVVQzRHkvdFdua09kUHdFekdzUlVs?=
 =?utf-8?B?NUlNY1htRlU5SDlwWURXM0dFcXdGdkhSVlFxOTJRb3I2enpqNWdVOWZqQ1Jq?=
 =?utf-8?B?UE9FbUtrZVJzalRCTWlkZVVxSVhPRDdIZFdOYWdEeVZCMnNqZEo3OEM4UldU?=
 =?utf-8?B?eEQ5NmUwZW5YbEc3ZnkwdkEvQ2JESllBUzJac1RrbnF6WkNZSjF4VDM4QVh0?=
 =?utf-8?B?S0JUZmJSdVM0Q2NRL3ZVQ0pjSDdid29lNllXV2V0bkVPZUlnNDZwdDBXZEx1?=
 =?utf-8?B?bHNmdC84N3RJT3RkNGowNUx0QUU2bnB4KzdZMGpINVpHeEF5Ni8wMGh1Z2la?=
 =?utf-8?B?WTZPSTd5SFB6RmUwamFkc2cyQnh3OVZYb1VsaFQ3WUpiTml1M3dQSnV5NThQ?=
 =?utf-8?B?NDlRY05LeUgrT0lSMkQwY01TZ3VEcnNvc3BCS0gyekxkdU5kVDZsSkthN1Yv?=
 =?utf-8?B?T0NEMUxjazZkbmlPOXJYdUxmWXpHUFFNdVFQcVgxQzVDcWVWNm0rZkt2T0Nn?=
 =?utf-8?B?dEQwQU5XSU1yeklCT1hqcGhZN2RiSWp4aW5PQWxxVjkxSURTelRHNHgyQkRi?=
 =?utf-8?B?elBMWkRHT2VpNEU0bCt1VklLNU9UbnJ1VFBRemJ1VW1VV1hwNmxVU20zYjIz?=
 =?utf-8?B?RDhZRWNvemIyTUdnMVdyMnJleVVuVGNUN1dsWTRxMUVKcFlibTc5ZFFubXRW?=
 =?utf-8?B?eWtVL2VXUWYwVCtqZ3dLQXM0SG0vMFhPR0tUR01Pc2hjVHVmS3UrZTNkbDhp?=
 =?utf-8?B?NGNuZlpSelludTF5UFVFbGQ3YVdKWmhhWGNCVVUrMlJUVDlWd2FHQUZ4QnNP?=
 =?utf-8?B?RCtla241MlVCL01wb3VqS0FhVW9MMmNqdzBISm8xT3UwcmpWNjZtZEhXeE56?=
 =?utf-8?Q?dI/j8hN8/eUixwjBjO4lsKuW/vXdKypW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnlqaDc5S1FWcUlhOUVwb2lsdFAzczY2Vm5ac0p2T1BuRDl1VHZ2cXJZcllV?=
 =?utf-8?B?c2lyeFpsSjNtV1dVZG1pcWhUSmJoUVVWeDdoM05aNGIrSFlmRjlUZFpSSDJj?=
 =?utf-8?B?SjRJcVE0QUZDNWt5TzVYQ0Y2YlhPZXFuK0s3ZHNFMDdtZDVpaCtZNTgvZTdJ?=
 =?utf-8?B?bFZWU09UdWlRU3ptaFp0ZUFKVWtPbUpFU2ovYmlJa1JkbUZyalBUUjVHRjc1?=
 =?utf-8?B?M2x3RVl1V2sxZ0dqWnA1TW1icUg2bWFLaDFiR0dQYzRrRFYxeVlDVWJUZm82?=
 =?utf-8?B?NTUyY3p5dk13dEh5U1FrSVUwcTZkUGZKTklpSDNJOEdIZjluRFpYemxURU42?=
 =?utf-8?B?YS9yZ24reXlqaElMRzlNYVUxSitIVWlIQWRjaW1PQjFzYjU5aHAvbCs1T3l0?=
 =?utf-8?B?S2ptUU01OXQ0bXpLRG5xbXBGeEcrQ01JYWMyTTFPVUQwdUNBb3R5QlJjWUEv?=
 =?utf-8?B?TUpuQ0RrZHd5WWluRzNwbVJvWkZNNURCcmJDNjNwb28wT3c4TWVZK0NET1oy?=
 =?utf-8?B?REZFSXc2dnphcXp5MW5xY2NmN1RpUnoraWNGS0x4R2pDdDg1Q2JPanhUS2xM?=
 =?utf-8?B?MHdCWGRXZjdHRURXZUVTVThJWDNybWNZTmVyWFl0N1VRYmpocWNIeHpXR3VX?=
 =?utf-8?B?Wms4eVlLQnBSV1Z0a2xxclBRUlozMjlGak5oVnRldTNlRFJEam5pZ0R2OUVv?=
 =?utf-8?B?T1kxZmJNSHhtVEluWlVxUHlaZlJBcTBXTmUveFpKQlhjTXhVZE53M213OGxN?=
 =?utf-8?B?cTRVS25wVHY0QlNjMGJ1eHdJYTAxQS9pUmdVR1QzWWJ1VlYza2FFVjJvemxG?=
 =?utf-8?B?MEFpK1pKclhOSENBZ2RPQ00yaU5oaEVYaDlQdWcrdFJxT2xKeldTNHMyNDV0?=
 =?utf-8?B?TXQ3cjZycTRPY0NNZ0c5V1I2VkJ2azZYUTVrUmpYZXdzOTlneFZZQ0tTUWlP?=
 =?utf-8?B?ZGNWckh0Z2hTbnFDODkvbzBVNUppTUFldDk3eUtQNHpNTWFVZFNEcjU2VkE5?=
 =?utf-8?B?WEZqdHdpQzZERzdQZDg5Njl3bnp4ZXc4aUNQdUtBRXhwVUdhTzl2dlNxZ2U4?=
 =?utf-8?B?MERLSVBPeld1cGo5MDF4WTJqQUd4bStoNEt5Uk5iS3hweDB1Z0NtQTRuYUJm?=
 =?utf-8?B?YmlUcVBkOWtPRWFYcW9BSWxEQjduSnJXWkFkanZQajBQMUJUYlJ6OGpWbWQ5?=
 =?utf-8?B?eHEwUXZIN1NpZVNtR1dWMjBXV0N4Rm1OTzZkUGJYN1JIZjNkZWR2OWhvNmNE?=
 =?utf-8?B?RVlFaVFZRTZsL3czM0VhMEt4SUY5aTdLak40TGZxN2cyRFBIdmp5aWZZUmRY?=
 =?utf-8?B?dTgwNFk0YUN6OER0aTFtYkVzaSt2ZzErWE9oM3BBWXZKTXdCcU5vOGg4Mm9o?=
 =?utf-8?B?RGpaSFd0N0JaVGFZWUxReDduOStqTlk4ZU8wQk9QMld6aU9sYnJmSGU0Zm1i?=
 =?utf-8?B?QW5CQmRMZ1NMSWlma0tDdWQvdXBSZEJUK1FSQ3Q3bGZKbXJ4YmpieHE2VXdR?=
 =?utf-8?B?K0cycHEvU01Rbzhxa3RiYk5YQVlpRk43WkYva3JDNFp1ZitQb1NPWGUrNVRa?=
 =?utf-8?B?M040SDRDb2hxeFpPWTVQZHR1a2hiM1RpMTZyVk5MK0pWR2UzeUI0M2VsSXk5?=
 =?utf-8?B?VEpXelFyZzZVcXJUSittQ2xOb2t1dVJ6MnRjWWRhUHNXby90TStPenBtWnNW?=
 =?utf-8?B?TGIwUXcvNk1SQk51WFJiTG45amRENForTUZ0Y1gwNGlyYXpDWjRjYkkvL1Qr?=
 =?utf-8?B?SlRoL2tlWkIzVEZicUVrbXRGSSswN2dDcUk3T0RkRlIwWDV1TGx5R0dUQWxW?=
 =?utf-8?B?S1dCUHc4ZmZyREEweldpL2ZNV2ZkdC9OM3ByR2krdzZKdzVwQVI1U0h1OUt1?=
 =?utf-8?B?UDVJbnFxZGdOQmg0dEVLWlBwRC9iSm5NRFk2WjRxTmVyNEZuRFZ5M09qYXVG?=
 =?utf-8?B?dTdqSHdNVnhjMXlnMElEV1h5TkhQbndpMTQ1T0ZXUlJib1BjSTY5eTcwcExZ?=
 =?utf-8?B?TjRvbmFqVUQyalNTWUI5RzBmQWErcnlLeG54aUNjN1F0UXlLU0JtZEtHTXpI?=
 =?utf-8?B?K3d2ZC9VRm15SXhKVE1kVnFxc1VybjlhYVRwNUNaQlR3UHVENTlHL1ZzZUlv?=
 =?utf-8?B?M05YeUZHbjhtbFdpajFqMDIzNXBOZzZGdjRzL29RZCtkbHJROHNNMkJVYnkz?=
 =?utf-8?B?UHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4aacc6-425f-4aac-8cb7-08dd653a5271
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 09:58:52.2053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQBwF6eKeuZ9Lre1eQQrRQBrRuNWOI5eMyo5sYKRnuRiKDSe3gLfOIMJrKwgfSXRLJZ53thN5KSsWevnPQM1oxetE1mEXRbVjoJNH6jFd7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11270

SGkgR2VlcnQsDQoNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1t
NjhrLm9yZz4NCj4gU2VudDogMTcgTWFyY2ggMjAyNSAwOTo1NA0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0IDA4LzExXSBjYW46IHJjYXJfY2FuZmQ6IEFkZCBzaGlmdCB0YWJsZSB0byBzdHJ1Y3Qg
cmNhcl9jYW5mZF9od19pbmZvDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gU3VuLCAxNiBNYXIg
MjAyNSBhdCAxODowMiwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90
ZToNCj4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+
IE9uIFNhdCwgMTUgTWFyIDIwMjUNCj4gPiA+IGF0IDE4OjMxLCBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhv
ZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+IE9uIFRodSwgNiBNYXINCj4gPiA+ID4gPiAyMDI1
IGF0IDEzOjQzLCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0K
PiA+ID4gPiA+ID4gUi1DYXIgR2VuMyBhbmQgR2VuNCBoYXMgc29tZSBkaWZmZXJlbmNlcyBpbiB0
aGUgc2hpZnQgYml0cy4NCj4gPiA+ID4gPiA+IEFkZCBhIHNoaWZ0IHRhYmxlIHRvIGhhbmRsZSB0
aGVzZSBkaWZmZXJlbmNlcy4gQWZ0ZXIgdGhpcyBkcm9wDQo+ID4gPiA+ID4gPiB0aGUgdW51c2Vk
IGZ1bmN0aW9ucyByZWdfZ2VuNCgpIGFuZCBpc19nZW40KCkuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Pg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8
Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBIHN1Z2dlc3Rp
b24gZm9yIGltcHJvdmVtZW50IGJlbG93Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYw0KPiA+ID4gPiA+ID4gQEAgLTkwLDExICs5MCwx
MyBAQA0KPiA+ID4gPiA+ID4gIC8qIFJTQ0ZEbkNGREdBRkxDRkcwIC8gUlNDRkRuR0FGTENGRzAg
Ki8gICNkZWZpbmUNCj4gPiA+ID4gPiA+IFJDQU5GRF9HQUZMQ0ZHX1NFVFJOQyhncHJpdiwgbiwg
eCkgXA0KPiA+ID4gPiA+ID4gICAgICAgICAoKCh4KSAmIChncHJpdiktPmluZm8tPm1hc2tfdGFi
bGVbUkNBTkZEX1JOQ19NQVNLXSkgPDwgXA0KPiA+ID4gPiA+ID4gLSAgICAgICAgKHJlZ19nZW40
KGdwcml2LCAxNiwgMjQpIC0gKChuKSAmIDEpICogcmVnX2dlbjQoZ3ByaXYsIDE2LCA4KSkpDQo+
ID4gPiA+ID4gPiArICAgICAgICAoKGdwcml2KS0+aW5mby0+c2hpZnRfdGFibGVbUkNBTkZEX0ZJ
UlNUX1JOQ19TSF0gLSAoKG4pICYgMSkgKiBcDQo+ID4gPiA+ID4gPiArICAgICAgICAgKGdwcml2
KS0+aW5mby0+c2hpZnRfdGFibGVbUkNBTkZEX1NFQ09ORF9STkNfU0hdKSkNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEJvdGggc2hpZnRzIGFyZSBkaWN0YXRlZCBieSB0aGUgZmllbGQgd2lkdGg6DQo+
ID4gPiA+ID4gICAtIFItQ2FyIEdlbjQgcGFja3MgMiB2YWx1ZXMgaW4gYSAzMi1iaXQgd29yZCwg
dXNpbmcgYSBmaWVsZCB3aWR0aA0KPiA+ID4gPiA+ICAgICBvZiAxNiBiaXRzLA0KPiA+ID4gPiA+
ICAgLSBSLUNhciBHZW4zIHBhY2tzIHVwIHRvIDQgdmFsdWVzIGluIGEgMzItYml0IHdvcmQsIHVz
aW5nIGEgZmllbGQNCj4gPiA+ID4gPiAgICAgd2lkdGggb2YgOCBiaXRzLg0KPiA+ID4gPiA+IFRo
ZSBvZGQgc3BsaXQgaW4gdHdvIHNoaWZ0cyBpcyBkdWUgdG8gdGhlIE1TQi1maXJzdCBudW1iZXJp
bmcgb2YNCj4gPiA+ID4gPiB0aGUgZmllbGRzLiAgSGVuY2UgSSB0aGluayBpdCB3b3VsZCBiZSBi
ZXR0ZXIgdG8gdXNlIGEgZmllbGQNCj4gPiA+ID4gPiB3aWR0aCBwYXJhbWV0ZXIsIGFuZCBkZXJp
dmUgdGhlIHByb3BlciBzaGlmdCB2YWx1ZSBmcm9tIHRoYXQNCj4gPiA+ID4gPiAobGlrZSB5b3Ug
aGF2ZSBhbHJlYWR5IGRvbmUgZm9yIElDVSA7LSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE5vdGUg
dGhhdCB0aGUgZm9ybXVsYSB3aWxsIGhhdmUgdG8gYmUgcmV3b3JrZWQgYW55d2F5IHRvIHN1cHBv
cnQNCj4gPiA+ID4gPiB0aGUgdGhpcmQgY2hhbm5lbCBvbiBSLUNhciBWM0hfMiwgYXMgIm4gJiAi
MSB3aWxsIG5vIGxvbmdlciBmbHkgaGVyZS4uLg0KPiA+ID4gPg0KPiA+ID4gPiBBZ3JlZWQuIFdp
bGwgaW50cm9kdWNlIHJuY19maWVsZF93aWR0aCB2YXJpYWJsZSBpbiBzdHJ1Y3QNCj4gPiA+ID4g
cmNhcl9jYW5mZF9od19pbmZvIGFuZCBTaW1wbGlmeSB0aGUgY2FsY3VsYXRpb24gdXNpbmcgdGhl
IGZvcm11bGEgKDMyIC0gKG4gKyAxKSAqDQo+IHJuY19maWVsZF93aWR0aCkuDQo+ID4gPiA+IFdo
aWNoIHdpbGwgd29yayBmb3IgdGhpcmQgY2hhbm5lbCBvbiBSLUNhciBWM0hfMiBhcyB3ZWxsLg0K
PiA+ID4NCj4gPiA+IE5vdGUgdGhhdCB5b3Ugc3RpbGwgbmVlZCB0byBtYXNrIG4sIGFzIG4gY2Fu
IGJlIHVwIHRvIDcgKG9uIFItQ2FyDQo+ID4gPiBWNEgpLCB3aGlsZSB0aGUgcmVnaXN0ZXIgaG9s
ZHMgb25seQ0KPiA+ID4gMiBvciA0IHZhbHVlcy4NCj4gPg0KPiA+IE9LLCB3aWxsIGFkZCBzZXBh
cmF0ZSBwYXRjaCBmb3IgZml4aW5nDQo+ID4NCj4gPiAtI2RlZmluZSBSQ0FORkRfR0FGTENGRyhj
aCkgICAgICAgICAgICAgKDB4MDA5YyArICgweDA0ICogKChjaCkgLyAyKSkpDQo+ID4gKyNkZWZp
bmUgUkNBTkZEX0dBRkxDRkcoY2gsIG4pICAgICAgICAgICgweDAwOWMgKyAoMHgwNCAqICgoY2gp
IC8gKG4pKSkpDQo+ID4NCj4gPiBXaGVyZSBuIGlzIGdwcml2LT5pbmZvLT5ybmNfcGVyX3JlZy4N
Cj4gDQo+IEkgdGhpbmsgeW91IGJldHRlciBwYXNzIGdwcml2IGluc3RlYWQgb2YgbiwgaS5lLiBS
Q0FORkRfR0FGTENGRyhncHJpdiwgY2gpLCBmb3IgY29uc2lzdGVuY3kgd2l0aCBvdGhlcg0KPiBt
YWNyb3MuDQoNCkFncmVlZC4gDQoNCj4gDQo+ID4gYW5kIFNFVFJOQyBpcyBzaW1wbGlmaWVkIHRv
DQo+ID4NCj4gPiAjZGVmaW5lIFJDQU5GRF9HQUZMQ0ZHX1NFVFJOQyhncHJpdiwgbiwgeCkgXA0K
PiA+ICAgICAgICAgKCgoeCkgJiAoKGdwcml2KS0+aW5mby0+bnVtX3N1cHBvcnRlZF9ydWxlcyAt
IDEpKSA8PCBcDQo+ID4gLSAgICAgICAgKHJlZ19nZW40KGdwcml2LCAxNiwgMjQpIC0gKChuKSAm
IDEpICogcmVnX2dlbjQoZ3ByaXYsIDE2LCA4KSkpDQo+ID4gKyAgICAgICAoMzIgLSAoKChuKSAl
IChncHJpdiktPmluZm8tPnJuY19wZXJfcmVnICsgMSkgKg0KPiA+ICsgKGdwcml2KS0+aW5mby0+
cm5jX2ZpZWxkX3dpZHRoKSkpDQo+IA0KPiBGVFIsIGdwcml2LT5pbmZvLT5ybmNfcGVyX3JlZyA9
PSAzMiAvIGdwcml2LT5pbmZvLT5ybmNfZmllbGRfd2lkdGguDQoNCkFncmVlZC4gU3VyZSwgSSB3
aWxsIGNoYW5nZSBhY2NvcmRpbmdseS4NCg0KQ2hlZXJzLA0KQmlqdQ0K

