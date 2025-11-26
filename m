Return-Path: <linux-can+bounces-5732-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31056C8AB58
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 16:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFC23B6762
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C47332ED8;
	Wed, 26 Nov 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="popUf8Fx"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011071.outbound.protection.outlook.com [40.107.74.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C93043AF;
	Wed, 26 Nov 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171679; cv=fail; b=XA3aFprgytLkz3CJJxZdgZiwcpEWfJNcaSJldSNhxMvjfC2h8YRaj8p6PBKBDLUE3XOCP71yBdXTOFnCGhvQdk96nyTrLwOl6i6efNEiTWaifi+CuuJKlM1TpFdCFateYbAWj20uYLmCRRYlFGUfJ4lbucWTsuTYc6QMoXO9Nr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171679; c=relaxed/simple;
	bh=Avx2V5kc8bT28TCk0O9c+k8y7+wf6xm+JaUdZ2wAhP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iodifBRgAa3rrbLYG8UBVDtvEVg1Y8YLs7ndb1UQYMUkFW/Vd4bPr2OuPCkGkgiiz5RbUEyP7D3UGK+/BQ4wqFz+Hoog08t0aPwSv9K8VPjUr+0skzfgXPqziN1eqO2qM3XJiw3Lm0PAF8NMKHL1KAXZ8hRHbvfTlqJpx6ZfkjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=popUf8Fx; arc=fail smtp.client-ip=40.107.74.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOZgo1c9c/5hJjg6G6ERp8NZHBp87KRwDsKmNJ+5VETlKOJdfohspQnE/PzwYn+Pfb53YMtHki+8DvUPnb4t/IHB5JnWYmdE2B1CRsOZHN27f1ots1/jR+25cPHmNc7aQ/WpasDwUQLi6X9Gh0UZsfS6IFhmbMRZQ0NyzyBsNDHdhE80VK8ZAFZJ5UzvCVxuSqglTG7cbTUZsdDz1nwcYDU+r69KKdkIJLsYmcNeEQ/bQYO0c1h6LHO2EKnZYOfzQOZ5x+aGivb/8gMPQYLdO5Ffd8IakCeuYXDlhJU6eGwAtCUqI9OpN84Yzbe9q1eeJvmHxUjYgNB4mSF7+U9Dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98DQ+z2AfaGccGDyrDMHApwH7KZ0+XmpRMqe9pVPB1s=;
 b=s1A70Fhy0ebqDGRrST3GHq9oz7PeckS6fyLUBv8kl87a1RY+5vm61+E0fLOV6F9jC+fSGNTpzC9EYYgHTW8rqJDkYzZwKPEw3gONNS+iE2wzPYnm8NMESBQp14JgzJH7CojYSBsX/iQKUF/LzQWaIeQXJonYMNM3ERbQxVtAupucwvhbtrqc8RkoqNfTY3p6WfL43ElilIPGOz86ywYmGlgwhoV0mwCG3BYfq/5TShxJt1p7+ECmkWm5ZPcSqG4KH33skjOIdnaxdSDUIfjTNL/GCoaWXhEzr5mRLMX7IgZ/yNnTwU6DhUD3bMke3tkLYBgvo6/yEgC2+zJ6LG2WVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98DQ+z2AfaGccGDyrDMHApwH7KZ0+XmpRMqe9pVPB1s=;
 b=popUf8FxN4dvvaUj/tr6+vC8DOsHyESexGu/uwEL61AyDAnW1Q+FsWDMl89mYrih66JUcK+dOXh5AmA+eecPjjdC0S9aLiJXdCMVme9djfb76qej5q+LjgjLS4/HcBeGGNr1pvTtaRhyURMb+k/wPeeBOasJZgmH6pDQTnMAAxc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10332.jpnprd01.prod.outlook.com (2603:1096:400:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 15:41:11 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9366.012; Wed, 26 Nov 2025
 15:41:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Topic: [PATCH v3 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Thread-Index: AQHcXupkjW8dAhtZfUGr4/9iMqgAf7UFF/Ww
Date: Wed, 26 Nov 2025 15:41:05 +0000
Message-ID:
 <TY3PR01MB1134600DA4C986A40585888D786DEA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251126153603.312265-1-biju.das.jz@bp.renesas.com>
 <20251126153603.312265-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251126153603.312265-2-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10332:EE_
x-ms-office365-filtering-correlation-id: 7c990fec-7ab6-45fe-ddf3-08de2d023664
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F22KQ08zXvJBsnplUkyHs8jXWLvx/aca0aNEHxQgunJOsafjllS3/7bpP+BQ?=
 =?us-ascii?Q?Oy6/CJ03CVhuofdLHS9z7zyWSKvstNK+KdDt0XsKZE8yOf2NDdXlTV+q7SkF?=
 =?us-ascii?Q?P14ozPamoPhdMM/LY3IqrOqEEu+RefjlTyLNynUVIbCyuJZl7z7RHj1FDsPI?=
 =?us-ascii?Q?LjYf6XmRXOGV6emxIeVr8o2CLyHK4RfTsF0MyVpTqdP0xXo7oHgflz5ZOOeU?=
 =?us-ascii?Q?OxDwYVJrtAhDgUArH0XSHXXGL/2BZAJz4qClnI53mn9XnLBLhHLsY6AetaNg?=
 =?us-ascii?Q?jRSTkdQrXdaArMcFKNPlLaJ/dSvTVvEH0ln6lcFURhzS7x/Wyvd1vSW/NvIG?=
 =?us-ascii?Q?Ag6mIfowo2anqjfPFTiYR25X1tEadN7cLMjUlCtEa53K7g2PQ7dIl+vFUvxM?=
 =?us-ascii?Q?lXmimTpBpLItqmpHFeBeJz1/ASOrHO2FaeZ9zqOSn1wjZAvFRSaeofG+0ZS5?=
 =?us-ascii?Q?SfctP3+KB6NYv49od3FX6sozvZ+03/Wse7pj9NjqAD7Qwotol6PpN/9ZqA62?=
 =?us-ascii?Q?lfK5je9ffIzI+7dwoznTDSvhtyrGOPQ4JzRWYKu6ZXdGF3M9tM6AD5jS4TKl?=
 =?us-ascii?Q?bshbX+V3k6YlA0I0f1pZqqmE9g7P9E0vPTOm1LniK2d4vRGAnWdVlWk9IlCW?=
 =?us-ascii?Q?oShVB5xe3vsx8ALBPvddeSmeXHMfzGGRCd6UZFs+/kjT0PLxp12fkPVRmc6m?=
 =?us-ascii?Q?4WSYuu/ZYWvYj4laQhQDrj6axaUqX1XW92XwndBdCwVlDkiNwIFmtKNYNI3/?=
 =?us-ascii?Q?L6grstBP7Tv0f8l+DmyDv2Rl2hf7yrFS72cAW224s42767HM6NWvM0JPboH5?=
 =?us-ascii?Q?9s7OhwhCM7zlMuC+/Hos834LvIUK9Rs+WXgX1gmMRK5m/0jBeisDJ1f7hWEu?=
 =?us-ascii?Q?b+rS3OOSig6qeEY+9Dk/6tvLA5tEDBFpgrnU2QYrZA1r9Y9WQ8Bea0vjNMN3?=
 =?us-ascii?Q?oJA7XoD5TwAGC47CGmJbszylBCSmgT+S8SpQQokiBKyMOIv/cD1rkIXWG40W?=
 =?us-ascii?Q?yH/7fwg8yqYXw9W+Ma09jjzD/SMREJVif68sgv4KfjCVr+RBTJtyy2Ej8ERM?=
 =?us-ascii?Q?6+wS0X7LfMhvn+3IxxCE1YpiKDxRl5ZqtWXAEAbCAWSMuPK7MtXCi2D7d2Qd?=
 =?us-ascii?Q?OUu4jqUaNPE2jamEsQ3DhCKoATC0FwzHIRu+VvaiJNhuopPJa+6jVjyEawI2?=
 =?us-ascii?Q?Bwhc7Fo0vQMhSYZD/T0KbJC/vAB6KpQdZNsd9Ry8JQ1/U487oOr7vKRj0SbZ?=
 =?us-ascii?Q?gp2ARzB8jFHusHOFBo8YpAFphf/eYzBW5KD5fY/9VL1adok8ZNMExya9T9XH?=
 =?us-ascii?Q?70PWnSKjyXCSLFLn0nc03uUeaaER4qauDy0vJ1zEtHW8MTaO8LkIUwe9h/Qs?=
 =?us-ascii?Q?50tilJrTcVZGNMk/FXSgDaFvy2VI68BNn2LCooa6CGhRLt1N2LGx+Qp3mQiZ?=
 =?us-ascii?Q?iT1xE+oEUgeoIkwRUJS8vcToC1IYkpLND9VzBCPEyXSvoiYylYfN/iAZN9Cq?=
 =?us-ascii?Q?ngBT+FOfCiJ8HMx43Tm2pr5oPLaT04QbX0ix?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vros3S24DSfasK1Pxx0lzviVg7wJVXpa9Yk36ujIaRGLeNlLbeK03Zr72XPI?=
 =?us-ascii?Q?m7YPzmbU9yAoodFvU/gOj/AAdHNajNsPvpwqqworQjbU/T2oMbf2cnPSLib6?=
 =?us-ascii?Q?CbXAOm2sk1NWxFcKLdKEZGdha3wb0WBsZmgpBGaOgZSWu/dnqS/2yIA0yK8/?=
 =?us-ascii?Q?e2AJXfpDUo5a9b8Y4IhtmXFhcT5WzP+dbXtE/V3lwsjROto1yF5JAU0KJCgr?=
 =?us-ascii?Q?swNR5ezEnw4Fr+76pwi2ehBW6OJN8rl+9LoyPWlC+wwfigP1pjHA5s1Qgl3x?=
 =?us-ascii?Q?aMFAeT2pZeFRi8zMAc6HhRtvwA5bgygegodSpYnAUMJSfV9ZiK41+dKFW5ag?=
 =?us-ascii?Q?Kp/chFisP9un8shs6cmiZhkvBLjo6drukXfIoJkkHS2+Mql6R8lSxtIbCmeH?=
 =?us-ascii?Q?bkCd3UY0UPixzhcvrw981OaXwdVfg1RECnHowURuOkwmQOvuIj5i757LahTs?=
 =?us-ascii?Q?0FlAf+UI3TF5YBZrUL0Vma4uBqh9DISUa/CRNeOsWfA3Jw1cGt/X7NAmspyF?=
 =?us-ascii?Q?GtkfKlPGCu1v1otR7S6WupfOskJrBrg6Zj3YVQQKYDhn0XGUKVMcXq70J7zE?=
 =?us-ascii?Q?I3sF5aI1xYj3xXaS9ZUNTIHLFz3mI119rJW59atBGAnh/oJZvbQ5Gqxhxzmz?=
 =?us-ascii?Q?flvcm7oe8BDNcboK8QbN8oMIdlyXGvrxj++13dJ2YmWud/9ixuu4rFNSXQcq?=
 =?us-ascii?Q?yINwDYCMSzXL+tRpauO94zvTmi1ANcUKKMwrltrvmxF+thL/dbMLKXVbJ5bG?=
 =?us-ascii?Q?kR9qXAmTK9wq0Y2N2h4gsbA5ws/BrECePgceOvqVzDUmpeDktPHEZkmpi5CA?=
 =?us-ascii?Q?yaMEpuveJ/nHXYCtAGFxQKi5nvr3X6UGANcMhd4T9PiOBBfot8/mqQDPsae5?=
 =?us-ascii?Q?1aUftK9XrId+H4QvFwNvdhCk+2VUo9i0EVWKAv0oz14vr1vFL24ETm/cGl2d?=
 =?us-ascii?Q?kjQ+uLwn6kar5Z2i8ubKFrpGstut3sdob0fBABioXlLA2vXeAHiazlJ65R2T?=
 =?us-ascii?Q?JDNI5lHJqr2x1O8Onm9V2LJ+jAZiiPjqBJ0e0UxIvqweKEw4ntSwC/Z+dc0Q?=
 =?us-ascii?Q?jR5chpj9jhsfXgsX78i6KUuoaSDPw4ZHAgmxoeclJwm2NZ5RG/ybrF0aZF5Q?=
 =?us-ascii?Q?VxafLOTxd+zJcPjR/gIj2rvuksAj273vkvWoYDJgAoQHGRcNkcNayZLaG7O9?=
 =?us-ascii?Q?56SxKBQxJCkrcPjzskeMt798bPx8XdV6jGxnfzWOisbQkWrK0nXG0yNCVl+z?=
 =?us-ascii?Q?nOB08HbDqyZCnSTIMB+H13mXoae/E9Do02EnaLhbBVliPffPAdxBhQUAaAFG?=
 =?us-ascii?Q?39dq6vxgJZg7Nnym+n3T9Y+IN/xzcGxHcQ55edzPEeaZ5pa9ZPWhKFTuztRA?=
 =?us-ascii?Q?z7jbz2jrd/8Ye7SR1OchlTgAObc8FDMCdD6yaw7v1R/DuzZGzmw83toAfMND?=
 =?us-ascii?Q?MZ1k87iMV2MJz+q/kS5N397RcVeFxSN9drs4p6mbZW7e/6HHPMBfG7LCwJEk?=
 =?us-ascii?Q?AfrTZ/G4zXaUGgajBgsJzD/mlPD6tjLB4ETnkyDF7ajEtVG8Wjd0fI264aU8?=
 =?us-ascii?Q?X7s58bp9cqwcR8sQIto3vFLCVgr2Ky2FqCYzRgdwigt+ypDJ6Z5t1EQj4AIV?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c990fec-7ab6-45fe-ddf3-08de2d023664
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 15:41:05.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARrAr6i47DX3EH/i8P5BH7kgprGK5I2oOh0kG6YVlAV5N3bkNx2MFtJZ8PfPh5YZjXdbo8qVkEiHefjg5WomxXXEjdK0zaEIXyhrduQugK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10332

Hi all,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 26 November 2025 15:36
> To: Marc Kleine-Budde <mkl@pengutronix.de>; Vincent Mailhol <mailhol@kern=
el.org>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley=
 <conor+dt@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.co=
m>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Fabrizio Castro <fabrizio.cast=
ro.jz@renesas.com>; linux-
> can@vger.kernel.org; devicetree@vger.kernel.org; linux-renesas-soc@vger.k=
ernel.org; linux-
> kernel@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@b=
p.renesas.com>; biju.das.au
> <biju.das.au@gmail.com>
> Subject: [PATCH v3 1/2] dt-bindings: can: renesas,rcar-canfd: Document re=
nesas,fd-only property
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only mode, Cl=
assical CAN mode and CAN-FD
> mode. In FD-Only mode, communication in Classical CAN frame format is dis=
abled. Document renesas,fd-
> only to handle this mode. As these SoCs support 3 modes, update the descr=
iption of renesas,no-can-fd
> property and disallow it for R-Car Gen3.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Added check to disallow the usage of both fd-only and no-can-fd.
> v1->v2:
>  * Added conditional check to disallow fd-only mode for R-Car Gen3.
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 74 ++++++++++++++++++-
>  1 file changed, 71 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml
> b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index f4ac21c68427..a504f94d0a20 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -125,9 +125,17 @@ properties:
>    renesas,no-can-fd:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -      The controller can operate in either CAN FD only mode (default) or
> -      Classical CAN only mode.  The mode is global to all channels.
> -      Specify this property to put the controller in Classical CAN only =
mode.
> +      The controller can operate in either CAN-FD mode (default) or FD-O=
nly
> +      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify =
this
> +      property to put the controller in Classical CAN mode.
> +
> +  renesas,fd-only:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The CANFD on RZ/{G2L,G3E} and R-Car Gen4 SoCs support 3 modes FD-O=
nly
> +      mode, Classical CAN mode and CAN-FD mode (default). In FD-Only mod=
e,
> +      communication in Classical CAN frame format is disabled. Specify t=
his
> +      property to put the controller in FD-Only mode.
>=20
>    assigned-clocks:
>      description:
> @@ -267,6 +275,30 @@ allOf:
>        patternProperties:
>          "^channel[6-7]$": false
>=20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,rcar-gen3-canfd
> +    then:
> +      properties:
> +        renesas,fd-only: false
> +
> +  - if:
> +      required:
> +        - renesas,no-can-fd
> +    then:
> +      properties:
> +        renesas,fd-only: false
> +
> +  - if:
> +      required:
> +        - renesas,fd-only
> +    then:
> +      properties:
> +        renesas,no-can-fd: false
> +
>  unevaluatedProperties: false
>=20
>  examples:
> @@ -297,3 +329,39 @@ examples:
>              channel1 {
>              };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +
> +    canfd1: can@10050000 {
> +            compatible =3D "renesas,r9a07g044-canfd", "renesas,rzg2l-can=
fd";
> +            reg =3D <0x10050000 0x8000>;
> +            interrupts =3D <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "g_err", "g_recc",
> +                              "ch0_err", "ch0_rec", "ch0_trx",
> +                              "ch1_err", "ch1_rec", "ch1_trx";
> +            clocks =3D <&cpg CPG_MOD R9A07G044_CANFD_PCLK>, <&cpg CPG_CO=
RE R9A07G044_CLK_P0_DIV2>,
> <&can_clk>;
> +            clock-names =3D "fck", "canfd", "can_clk";
> +            assigned-clocks =3D <&cpg CPG_CORE R9A07G044_CLK_P0_DIV2>;
> +            assigned-clock-rates =3D <50000000>;
> +            resets =3D <&cpg R9A07G044_CANFD_RSTP_N>, <&cpg R9A07G044_CA=
NFD_RSTC_N>;
> +            reset-names =3D "rstp_n", "rstc_n";
> +            power-domains =3D <&cpg>;
> +            renesas,no-can-fd;
> +            renesas,fd-only;
> +
> +            channel0 {
> +            };
> +
> +            channel1 {
> +            };
> +    };

Oops, Added testing device nodes by mistake.

Will send v4, fixing it.

Cheers,
Biju

