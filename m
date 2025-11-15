Return-Path: <linux-can+bounces-5422-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CF2C6066C
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 14:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E1BC4E30A6
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF152FB0AE;
	Sat, 15 Nov 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="S5oZlXNR"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011061.outbound.protection.outlook.com [40.107.74.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E726CE1E;
	Sat, 15 Nov 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763215049; cv=fail; b=GdFEugmIDJLc+UQ0gDJT6N6/TcNqpCWrHsyPhbWFgBwBiXyx3cYWm/5lEBTOnY7LxTj8sQKdxwk3nbBXs4QqAaOzdTsNa1OISEQ4Nca2+pPheM9s82iAb766DaCz9BCmQqHOEeHLcqenm0jOBbT2fQPY39K3JDC1IKzexfqUK2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763215049; c=relaxed/simple;
	bh=7a3GZHon/aMw3eZ0iUBKNdvZC2hjxrAf3B1Gidw+MBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1s2DjJWNKJrKBOSHZXw+LLThBJgHnz5eM3rXma0Kcj/PR6G91hLalw9RpbrqfyARYaqI6/bW8HSw14WfdWrCWHFtoqAYZe5fC4UEssVOtP7ONNcdf1yj4aJ1UujrY/Iu7fogl86XQa8zRFNid2zUBNXehQslTatFcLpX7kzj7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=S5oZlXNR; arc=fail smtp.client-ip=40.107.74.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF9B/dIsERD1GPbjuOKY9ICS66N4JNepmHrMEs1A5cxpKy4cDcXLk5q2q/2jDOf06qg6KaSZeE8hlXy0Rd/+yCZck6sYam/4tvTSYMj+KivCKP8iSTbCzsFEE2axBspiVTaifbWHeIxUtW1UFYtPI4UJXzKuGXbH9rJEdGavsoQWYqsjrsjdah3D8IB3UMYSxu0QylNU/BcxDiwVkuetxsgWN0bOW0Bde6tiRUSKdOERz31hA4djpRWLuzTDvidyrG5dvkdf5BqxD5a64+ZruCqNSoZa89UboFL5OKhHwYlq9eNzG02z/bOAJOnrtDSX/SCZlQDNbSzDQnVFOA55YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a3GZHon/aMw3eZ0iUBKNdvZC2hjxrAf3B1Gidw+MBA=;
 b=atX71FNf4YvheO0AhMTfdH/gfVcmEXuvq/8SdRFqDeC4MO7oXcw/0YtHXULfAtUJRxNz41yv2+qJa8WrDa4URWfAn8q2OVGApAYDKrtDgfFK+7SMhiCHbuva8ue3zvJG0MekgJ2DK1h1j6PSa2Et4Gc9fntNYGkHKUon5+dgMVySuvYFstj3PirJxz8zW/mFGfwdAtvTuhqHhUjnTD6rRREV9dcCUBvzEv+EzkANwx5yHgR2tIZ+T2TUU9cM8/wgrGcVF6mJJAQu+d+TcrcG2uhU8HeAQp5PUaOk+q5ehxt9xjoDXsuEq1SV2DmPROh9KZx5JldBuGSGIEFo9Dz1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a3GZHon/aMw3eZ0iUBKNdvZC2hjxrAf3B1Gidw+MBA=;
 b=S5oZlXNRK8By83lX92Ri+pJMw5U/qYIRAdOLKD/sOTbaJVVYfJ4xP0cQQHCGCMw9Wrut3723qCy66LhWAXPcyPfY4XXh4uaQDplJrL8iIfXEQl7E1MPC1OujnyHXr3uT+CyGqZEdtc75cIC2kV6vJBAEd03P+8+it/5OGaCSOF4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB8839.jpnprd01.prod.outlook.com (2603:1096:400:16e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.8; Sat, 15 Nov
 2025 13:57:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9343.008; Sat, 15 Nov 2025
 13:57:13 +0000
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
Thread-Index: AQHcSZVzMv+xB+/yKU6ldKbXUm40nLTuzr2AgAUCCvA=
Date: Sat, 15 Nov 2025 13:57:13 +0000
Message-ID:
 <TY3PR01MB11346974232A057A7D5B6EBAD86CBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
 <20251112-warping-ninja-jaybird-22edde-mkl@pengutronix.de>
In-Reply-To: <20251112-warping-ninja-jaybird-22edde-mkl@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB8839:EE_
x-ms-office365-filtering-correlation-id: 10ce797c-db1e-4262-1c5b-08de244ee100
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2FGOVV5cFZaT1g2U1hWaEtTZnVjSm8xT0VuNkRzcEVxcDluemJwc0dyaWQ5?=
 =?utf-8?B?M1dIVnY2dkJtUnVJT0RRL2g2ZUJYUGV5MG5Pck5wUDl1YmhkQlZKWlhYS0RO?=
 =?utf-8?B?SkgzbVl1aXNLNDgyYnYzTy9iS1FQeFg0dE12MGl5cWJmNWhxQTdtb1dkQXov?=
 =?utf-8?B?cDRqYUJKQ3l6a0t6ODgrbHlSamxJdXcwVG9WaExKZXphaWI5aEFKUzAybW9p?=
 =?utf-8?B?Q20vV1ErVkdKSHJ0VlpGdjFoZ2hhRjRydkJSWG1XUHJ0dDNhUm1EempEc3Iz?=
 =?utf-8?B?cWwzUjRRdUo0eUw2T1NvUTVibWFxM1RkMHhpbG00em9pTFZZUlM3Vy9UOUp4?=
 =?utf-8?B?dDhRbFFCUEJORFZuT0YwYzFZZnh5UXRPajYzeTBiNXBvb0VjcytaeElZZy9u?=
 =?utf-8?B?QmNnUHpxYnVTUkZ4NHFTNXZkZk90NjFodGtpemRMU3ZBdk1PZ2xuK1FTdVF0?=
 =?utf-8?B?S0VQQjRlRHZ3M04zY0JRS0dlM2p2ZGhZSjVTcWpCSnQ3Ny9QUWt6bzAyODBa?=
 =?utf-8?B?aUQwb21YN3NLQ0NyZWlBOEh6Z2NCMlRyaC9GWXAzeXlBOURUWVlZNXNiUUtK?=
 =?utf-8?B?RkZmRDRGbWFrNU1lZnVxN2NKS2lOQW1leEU2TjA5eXlHYlR4ZkxhUENvMUQy?=
 =?utf-8?B?QnBQSzBqSHZaeEMxMG9BaC91cVplV3VxUGMrczE1c1VyTHNFUkt4RUEybkxB?=
 =?utf-8?B?aTdvTVNnRFd6eVRzNm5DYmNZbDllQVVVZ2RkUWVmcEJGaGRrZGRiM0o1bExF?=
 =?utf-8?B?elZWOEF3dUcyWW5PRTV5MWFuNEQ2NkhmMVNFNGt6eG5wMWQ3TWk1b0lRN2Qx?=
 =?utf-8?B?bzlneVMwc1BQbTZ4WFNGcUFvY0xmQXlCNEplajU5MVNNWlJEejZ1eC9sRzBU?=
 =?utf-8?B?QVMvVjhobGNibFlYdUE0dnl1YTFWUWVQOE9UdlpndUx3amxKaUs0KzVWd2Fn?=
 =?utf-8?B?RGd0R3hyb1NVZjROaGkvczhIMDlQZWxERXVoNFRudzN0YnFNTzllSEJLOTVT?=
 =?utf-8?B?OGYxTk05d1dCOTZjYXNnMnRwT3VmVmZraGVLdGZXU2F0eTlwaGs0TzRtVjRZ?=
 =?utf-8?B?K2hFYitFNVk2Qzk1VEFlVERnY2FOenNETU00NWZGdGtVYUZBMklmVEY2NkRs?=
 =?utf-8?B?NXVnZmg4U2xFNE1mQ2hCdTUvZ1hyYUZRYWZvYjNoQXZsV1FyTjdVQVlubVc0?=
 =?utf-8?B?RmdUWitWaUhxYThla2tVekVlWW50NUsraXNJc1hoRGkrWXVOWlVlL3ducmh6?=
 =?utf-8?B?M0s2ZFpPWEpKRUdUMFVmSDZKTHZBa2p5cjh4eDJzRkZmNUc5S09sNzg2Qy85?=
 =?utf-8?B?TlBxdnNKNlJkc2ZMckc0QlhMWGNxbVU1amVObE0rZStnQ1Zqb0QwTU55b01M?=
 =?utf-8?B?OWR0QzU0MXh2OVVRMkV6NDJNUUZqWnNiVkZ5Rjg3S0UwZzA5U0NVUGVvQmJi?=
 =?utf-8?B?a0RyMkdnMEdUMjR2VjhVdTV2N3Q2cnpoaDFJZUNWU2VQZFBmRlhoR0FJVXlE?=
 =?utf-8?B?NEVQL2lkYlo4NXpPRXEzU3RMNmlOeExkZk9yMVBBbUNMSFVqRDA1WnorSFdE?=
 =?utf-8?B?WU9FajN4VnB2V1Fkb0U0Q0JGenpNRCtvMDRYSkx5N1F0S2hodEhZWFhZTTlz?=
 =?utf-8?B?OStNVUpnVmZPTldyRUVTT2xWdGk2UFVMUmowVFExSWt1SVhzb004dDRmN2ZE?=
 =?utf-8?B?WnpNbUxueHhzbEhHSy9tQUVqMCtiVTUzMWRnUVFvWGZGMHdZQk84RWsvYUpO?=
 =?utf-8?B?cllwZW1ZVzFYM0o0QkNaTDNZdTdKWGVKVDFWTExncG9BUExlRXE3d1NrbmJP?=
 =?utf-8?B?ck9LMEhMcmUvN3pmSWJtc2RkYTcwN1g1REFRbyt5TGs4WEVRMzk4WS8wUmxL?=
 =?utf-8?B?TGxGZE14SUovcFRyZ3ViV00wRmNSYk56WHdFTys1UFJDUUlzaXFUSGdZRVdL?=
 =?utf-8?B?Tk5jZ3lobmlOakFHU0VDVjBBR2FNVzNiaVBwcXZwZlN5Uk0xQUZrODFWTno4?=
 =?utf-8?B?ZzFtamJEeGM3MDlsUGNyT3FCb1dlYjFzOGYzWVh0dFE5ZmdJNU1TaCtTdGZY?=
 =?utf-8?Q?rJ9WFT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUtwV0JYKy9pQXJ0ZmJYdmJMS0VGeFhxN2ZDK1dlYXZ3aTZQS2xMSGVhS0pt?=
 =?utf-8?B?M2RLSjlvYnpFUjVMUzEyN0wzK3dtUTVqaWlnLzNaMktveWQvekF5UTV5YjJQ?=
 =?utf-8?B?Y0lkRXh0VXh6bVpBQ3hzcldsQ25QWU9MMEZuVUxDY2lNVVFoaURHc2doNFFu?=
 =?utf-8?B?Q1ZmQmpsMnNJT1BOOXhLdmZTcW40WnNCdTlrVEI2WmlwQ0lRYlpBcEFuZCsz?=
 =?utf-8?B?NU9XUkNwVGU4a2dUWDdsODY3TGtQaTVHazVYVXFPNk9wV3FGN3RZdVhWTnVW?=
 =?utf-8?B?dmlJUDFQaE13ZXFPcmJmY0Y2bnJLYVExYmVCcGZsNTR6a2FGTGtuaFBzbXQv?=
 =?utf-8?B?VUg1VEU3MVZYcGR2bGovMzhZbzV4NWxFQ0oyb2RqMmhsU2hqbkxXd0dRMUta?=
 =?utf-8?B?VmFZUDZrajFXSkZiL2ZYQmNXRE4vKzhOTWtVNy9GSHJFVVJnSXgyaUFlYktu?=
 =?utf-8?B?RWpKNSt1N1dOVFJEOHJOQkdmVVdTOGVHZlp5ZjJjRkMzNWhsSHVwbzR3NkUx?=
 =?utf-8?B?NFF6UkRXc21XTW5Ub0lLZUtsdU13RTNNZ3ppSFdxNGt6VWZ3d1JKZnpMd2cz?=
 =?utf-8?B?WFk3YXRNcExBM0pheU54Qm0wWXJ6cHU0T2kwV3Z5ZklBODJCZkQ0dW83L3dP?=
 =?utf-8?B?eFlTZmQ3WlA1L2s1ZzUyYU9vUzNEeTBDVjd3NkFKcHNIZUVEN3o1c0RpaEZx?=
 =?utf-8?B?ZVY4dyswQ25nYnpFdzl5cXdaOU01SVpGRVV6STFIY1hhdlA1T1NsVnAvVWN2?=
 =?utf-8?B?b0ZGTlVSWTRGZ2hYZTlwT3d1SlRTeGJVVnpDMm4yMkVhc25WRC90VlhMRU9i?=
 =?utf-8?B?TUk3NkVrbzVuSlBES3Ird1pPb2huZE8rNHBJL2Jpcyt5U2pDbGtCd0Q4V1JL?=
 =?utf-8?B?WWE3U1ZVMXBkZ3pMZWFrM0ROZmVRR2doeGV5VHVoQm5ycTROYWRvRmZoMVNw?=
 =?utf-8?B?Q3dVWFVTOGw0SXU5R2Z2YUg0Q2xCcUh2em1LUC91aHhnTStBSXIzS3hsQWVj?=
 =?utf-8?B?ZXFUQlhoRmdmemdpZEUyTGVaaW5QTUh4N2gzRU1wSjhmdFdObm9qbEVEN1hK?=
 =?utf-8?B?ZjcwcU5yNkcvVytzbXcxeWFFczQ5dk5WM1BVWkdvbVpydFB5WXdnOFlIYXU4?=
 =?utf-8?B?dUpjL2tYejlSNXlOQjZsLzNxMVl2ZkxHNk02MERNeVYyVklWLzZLVlJnVmlK?=
 =?utf-8?B?Yzd5WDkyL21TRDM1Z1FJZmlHamtVL2pKd0lrSzVyQ0RNZVV0OVJnM3ZreVBx?=
 =?utf-8?B?YnliVDB3cURjKzlSMTYrQkE3TUIyK1hYY29EQ2tycEF6OFIvNGJkUWwrczZC?=
 =?utf-8?B?VGVrQzF1dWtydmowRkszdXl2U3h3NkpMSzhCL2pqNWFTR0tJWG5zMlF2RFE3?=
 =?utf-8?B?NzBsQ1JiTFRZaGVaZktrbm5IcDBmczlsWjVIcmEvanIrM3JzcExLNlVuL2NM?=
 =?utf-8?B?NnhROFZoRm5uczJXMEhZMlpBSTlIa1JQRDRhT2Ztak1kcFhsdVdTSXNaQ3I5?=
 =?utf-8?B?aTFLdDVGRTJpdURzTTAwWkoyZlp5TzcveFpNWjZpVGs3TGtjMXcwK1BtcXVF?=
 =?utf-8?B?LzNqT2NMbzY1TXpyK21MOXNabFRNalVQdmxZL3JHVnk0VWNKQ0ZMY1R0RmZy?=
 =?utf-8?B?aHEzTldBVDZ3eGYvTXc3K3ZuNndwRUhXQXF5a0dMWm9VVkkwa0hBQnJ1T3dJ?=
 =?utf-8?B?Vm5xWVlQUjFUaVpaclN1OE5xc3ZuSTErTGNqSlFxRCtTUERnTjdieWR6ZlBi?=
 =?utf-8?B?bFBMdEhVQ09nYk5WVW0rV01HVXVUWXNDbE5PQWwrOFdvc0RjUHVQTDNWcFFB?=
 =?utf-8?B?MnFRelM2cXlIa1llQmxlU2Q0eUNWR1A2RDdzM2t3UHNPakVRVERzU0hjYWZa?=
 =?utf-8?B?WmNFVzBUVDFhZEZkQk53cnphaytvTHJiMkhVL09aOXdQeDA4YjUxRE5NcmNa?=
 =?utf-8?B?T3NhNmRFNHVuOGpkK28welZnTHJ3NFJyOGtqTmVmSEgyL25jKzNpaDdUV1RK?=
 =?utf-8?B?VElrUHM5MlFmK0VIZytHSzVPWVc3MG9tYjhUMG82dHFaTTUraWZlUC85UGg0?=
 =?utf-8?B?RUFja3orUFRhVDNuVzEya0YrMHgra1QzZ3hJLy9DUkw1NU5CRGt5cTNyYnZu?=
 =?utf-8?B?NVV6R0x3TWFSV1lYZlBxbzY2UWF3bDZBQm4wWFQwaVVJMWdlc3k3SnJsaEto?=
 =?utf-8?B?MEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ce797c-db1e-4262-1c5b-08de244ee100
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2025 13:57:13.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qFzCt5+dWpnQIEe3NRp4zdSgeTxp8FOfrC23F9maqf51f2mMMoSY37ajC7U2BGCHm1G0f8mjrGmPER/zBBnTfI4VDtpVjTfitAhYHXVuhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8839

SGkgTWFyYywgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMTIgTm92ZW1i
ZXIgMjAyNSAwODo0Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjYW46IHJjYXJfY2FuZmQ6IEZp
eCBjb250cm9sbGVyIG1vZGUgc2V0dGluZyBmb3IgUlovRzJMIFNvQ3MNCj4gDQo+IE9uIDMwLjEw
LjIwMjUgMTI6MDU6MDQsIEJpanUgd3JvdGU6DQo+ID4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+ID4gVGhlIGNvbW1pdCA1Y2ZmMjYzNjA2YTEgKCJj
YW46IHJjYXJfY2FuZmQ6IEZpeCBjb250cm9sbGVyIG1vZGUNCj4gPiBzZXR0aW5nIikgYXBwbGll
cyB0byBhbGwgU29DcyBleGNlcHQgdGhlIFJaL0cyTCBmYW1pbHkgb2YgU29Dcy4gQXMgcGVyDQo+
ID4gUlovRzJMIGhhcmR3YXJlIG1hbnVhbCAiRmlndXJlIDI4LjE2IENBTiBTZXR0aW5nIFByb2Nl
ZHVyZSBhZnRlciB0aGUNCj4gPiBNQ1UgaXMgUmVzZXQiIENBTiBtb2RlIG5lZWRzIHRvIGJlIHNl
dCBiZWZvcmUgY2hhbm5lbCByZXNldC4gQWRkIHRoZQ0KPiA+IG1vZGVfYmVmb3JlX2NoX3JzdCB2
YXJpYWJsZSB0byBzdHJ1Y3QgcmNhcl9jYW5mZF9od19pbmZvIHRvIGhhbmRsZQ0KPiA+IHRoaXMg
ZGlmZmVyZW5jZS4NCj4gPg0KPiA+IFRoZSBhYm92ZSBjb21taXQgYWxzbyBicmVha3MgQ0FORkQg
ZnVuY3Rpb25hbGl0eSBvbiBSWi9HM0UuIEFkYXB0IHRoaXMNCj4gPiBjaGFuZ2UgdG8gUlovRzNF
LCBhcyB3ZWxswqBhcyBpdCB3b3JrcyBvayBieSBmb2xsb3dpbmcgdGhlDQo+ID4gaW5pdGlhbGlz
YXRpb24gc2VxdWVuY2Ugb2YgUlovRzJMLg0KPiA+DQo+ID4gRml4ZXM6IDVjZmYyNjM2MDZhMSAo
ImNhbjogcmNhcl9jYW5mZDogRml4IGNvbnRyb2xsZXIgbW9kZSBzZXR0aW5nIikNCj4gPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IEFwcGxpZWQgdG8gbGludXgtY2FuLg0KDQpU
aGVyZSBhcmUgMyBtb2RlcyBmb3IgQ0FORkQgb24gUlovRzNFDQoNCjEpIENBTi1GRCBtb2RlDQoy
KSBGRCBvbmx5IG1vZGUNCjMpIENsYXNzaWNhbCBDQU4gb25seSBtb2RlDQoNCkluIHRoZSAiRkQg
b25seSBtb2RlIiwgdGhlIEZET0UgYml0IGVuYWJsZXMgdGhlIHJlY2VwdGlvbiBhbmQgdHJhbnNt
aXNzaW9uIG9mIENBTi1GRC1vbmx5IGZyYW1lcy4NCklmIGVuYWJsZWQsIGNvbW11bmljYXRpb24g
aW4gdGhlIENsYXNzaWNhbCBDQU4gZnJhbWUgZm9ybWF0IGlzIGRpc2FibGVkLg0KwqANCk9uIFJa
L0cyTCwgY3VycmVudGx5LCBDQU4tRkQgbW9kZSBpcyBlbmFibGVkIGJ5IGRlZmF1bHQgYW5kDQpP
biBSWi9HM0UgYW5kIFItQ2FyIEdlbjQsIGN1cnJlbnRseSBGRC1vbmx5IG1vZGUgaXMgdGhlIGRl
ZmF1bHQuDQoNClByaW9yIHRvIGNvbW1pdCA1Y2ZmMjYzNjA2YTEwMTAgKCJjYW46IHJjYXJfY2Fu
ZmQ6IEZpeCBjb250cm9sbGVyIG1vZGUgc2V0dGluZykNClJaL0czRSBhbmQgUi1DYXIgR2VuNCBh
cmUgdXNpbmcgaW5jb3JyZWN0IGNvZGUgZm9yIHNldHRpbmcgQ0FOLUZEIG1vZGUuIEJ1dCBmb3J0
dW5hdGVseSwNCml0IHNldHMgdGhlIG1vZGUgYXMgQ0FOLUZEIG5vZGUsIGFzIHRoZSBjaGFubmVs
IHJlc2V0IHdhcyBleGVjdXRlZCBhZnRlcg0Kc2V0dGluZyB0aGUgbW9kZSwgdGhhdCByZXNldHMg
dGhlIHJlZ2lzdGVycyB0byBDQU4tRkQgbW9kZS4oR2xvYmFsIHJlc2V0LCBzZXQgbW9kZSwgY2hh
bm5lbCByZXNldCkNCg0KVGhlIGNvbW1pdCA1Y2ZmMjYzNjA2YTEwMTAgbWFrZXMgKEdsb2JhbCBy
ZXNldCwgY2hhbm5lbCByZXNldCwgc2V0IG1vZGUpLCBub3cNCmFsaWduIHdpdGggdGhlIGZsb3cg
bWVudGlvbmVkIGluIHRoZSBoYXJkd2FyZSBtYW51YWwgZm9yIGFsbCBTb0NzIGV4Y2VwdCBSWi9H
MkwuDQpCdXQgYmVjYXVzZSBvZiB0aGUgZWFybGllciB3cm9uZyBjb2RlLCBpdCBzZXRzIHRvIEZE
LW9ubHkgbW9kZSBpbnN0ZWFkIG9mIENBTi1GRCBtb2RlLg0KDQpJcyBpdCBva2F5IHRvIGRyb3Ag
dGhpcyBwYXRjaCBzbyBJIGNhbiBzZW5kIGFub3RoZXIgcGF0Y2ggdG8gbWFrZSBDQU4tRkQgbW9k
ZQ0KYXMgdGhlIGRlZmF1bHQgZm9yIFJaL0czRSBhbmQgUi1DYXIgR2VuND8NCg0KQXMgYW4gZW5o
YW5jZW1lbnQsIHdlIG5lZWQgdG8gZGVmaW5lIGEgZGV2aWNlIHRyZWUgcHJvcGVydHkgdG8gc3Vw
cG9ydCBGRC1vbmx5IG1vZGUNCmZvciBSWi9HMkwsIFJaL0czRSBhbmQgUi1DYXIgR2VuNC4gUGxl
YXNlIHNoYXJlIHlvdXIgdGhvdWdodHMgb24gdGhpcy4NCg0KQ2hlZXJzLA0KQmlqdQ0K

