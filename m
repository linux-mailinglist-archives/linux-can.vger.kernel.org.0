Return-Path: <linux-can+bounces-1572-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040CE98862E
	for <lists+linux-can@lfdr.de>; Fri, 27 Sep 2024 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139881C221F3
	for <lists+linux-can@lfdr.de>; Fri, 27 Sep 2024 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F0FF4F1;
	Fri, 27 Sep 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="h247B4S1"
X-Original-To: linux-can@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020098.outbound.protection.outlook.com [52.101.171.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C96AAD
	for <linux-can@vger.kernel.org>; Fri, 27 Sep 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443441; cv=fail; b=VgOv93GPlS048bN7tnEs686mY5dzyzVlHxjLVXV8y8Sj5J8m5BsENBLxegZ0GpxmQQdwLv406rG8eA8SgyPPSR2z/uaQNdUfnsF3cJ+2cr18zCNqon3C8DTR7smET80hqDsrSeWQYWfj/tshpKR7V80Y0AyZ22CpynJLIuJDKR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443441; c=relaxed/simple;
	bh=YAbW6lbOZrJj7HUjez9FeloCt90o+iebnIiGs5wjRso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RSbIh4ogBxwG7JpaHCK5Rgy2ych8QxEqVEDI0lCWIiEbVrmCLAbAXpoQJL2Nw6JMpvDO8HjqK5ufv8MK73pXin2TAXS6OL/IX4kv9k+51qsb2A44dbnprNnrq/iFDNb2PkR5h1SsUm8F75gK/ncRyQFd5b2F3ypqGumADcxN+0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=h247B4S1; arc=fail smtp.client-ip=52.101.171.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgkdCWTfHeUWdiwsjBbNFHy485ZjAXQEaQwhf8L1hEh4z2gCf9mwh0ewp1i96oGnFPQcJ0CFe5dayN+nCD1GuZBegp1W/F4xDVG+riLKndOkafmtv3/AB0ZLRyl0X6wseTmBq/CTVuS0j64Sknxb05AxgHXACTrsazhiQT9NgtygklufU4NjMxpVrpSV405dt7onnQ1D05OeAVFSjskffMPowve34vzJn7ORQCqCRWVPsw1tq0xLnhJqahLsV7bAiup+5rzFSCYII1YsoZ5tF7va9NItcKG4obj0XSOHts1CaJ8aL9Vi8/6XXbGr5gRYJ26E6siQJAo13ppdX3uotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sKJU/RiS7gtsjlNuaYTWtZbZ3rWrfTa5CwiL2pQbAw=;
 b=OZHiCSEMRI/JjAMOhYEiXo8ElKg3eKdyngeGBj+cxWLTEiNhQdg7puyX907UoyfxZKV3vf3id3SKSxGV2XqJ+a+Owy4PdIQDEzhwmB+8yPnbbfYpxV8gLBZfG5kUqf6bL2+NNVWE6TQ7/8LhaKSbKOvI9fEmMvfk/JzlpTeOR7vK8YWX/gN/j58bFQepBJfskJoAYPRvoMsA4AVLkjz3tYVZBTbiqx0QQ0AnB/JdP2bKky1euGEuBJ7R7idHUdnfcZxZkNI4NS7FVqEX18L3VoOhVXnuxqZrBqopjgkKqUxv8VOwZLy6qsj1t470FnYiAi1He5VMVjUtJj1kBf4XPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sKJU/RiS7gtsjlNuaYTWtZbZ3rWrfTa5CwiL2pQbAw=;
 b=h247B4S18CUeHFYI+DEiGWc3tBqZaq1C1Y3nDTpzcUZRRqGTf73UL5A0zEDn9iGU5CPWGmdyD2q8uvKFCsFETOojI6ux9sMfs8gixmcxO4c0Tr0EGQtOwOPoBzqOeQrb5GYAz0P5Fhl9/AXVT0p48dWn21ty74vqM7Vbu20prAs=
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6d::6) by
 FR0P281MB3371.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:56::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.23; Fri, 27 Sep 2024 13:23:54 +0000
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fba4:515d:ba88:16dd]) by FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fba4:515d:ba88:16dd%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 13:23:54 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: AW: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Thread-Topic: AW: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Thread-Index:
 AQHbDxyIwLNmNNZaPEKJQg5t9sHOZbJokYSAgAGdlPuAAA2pAIAAJqvqgADbXQCAAGFHNQ==
Date: Fri, 27 Sep 2024 13:23:54 +0000
Message-ID:
 <FR3P281MB1552D0C69616DA620C2629ACD96B2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
References:
 <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
 <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240926-pragmatic-colorful-lyrebird-dc8068-mkl@pengutronix.de>
 <FR3P281MB1552B40D19AF9DE8CA8150AAD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240927-utopian-super-dolphin-88a1d9-mkl@pengutronix.de>
In-Reply-To: <20240927-utopian-super-dolphin-88a1d9-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1552:EE_|FR0P281MB3371:EE_
x-ms-office365-filtering-correlation-id: 79c79385-93bc-4a26-fdc2-08dcdef7a2b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rHY9FnSN61cMAtHb+BJK27iUh8/2X0f3o+zzAolpxywS9BnQxWu7W8Gkfz?=
 =?iso-8859-1?Q?OW5nITfAft6+5mCp2t7y1iH23zdg3ea4yJg15qUqNFurA+nNWvnkTG27Xn?=
 =?iso-8859-1?Q?cmhwJrp1xrXXtRbt4Hepss0umrTyZ5LmpYSb+j9gqMcP+DnD9sQ/qxWExr?=
 =?iso-8859-1?Q?l4hdlHXx7vh7GW4f2diFHMG++JSJ7PnJaKUoptFuGGTIQWV6X8mdVZQc8W?=
 =?iso-8859-1?Q?glVdNY3Jm/W29vSTwrbHoXQgKIn86+ibpkykIf3c1Ns7sv4dhe7u3YsxGE?=
 =?iso-8859-1?Q?f2kjqmZiahSn4nblIpj6ngS5Bj3JF/WtYsqWHcCbmLmNPUPzmQCiF7Wc7f?=
 =?iso-8859-1?Q?vSlfOLFQLCL4bZSMztxaHCrwm49iOGoF25MXwyQ6SJz89fBRh8/oGH/afD?=
 =?iso-8859-1?Q?DAriAVdIXVDKb9r2rtvR20F/mYQzDLig7DKftLUT/mZVn19u20eURYhP94?=
 =?iso-8859-1?Q?fYS936vZBU8L8LYF41suocVePHF5GsqjyjUU8c2aE93OiFrSgk+hgK/sHj?=
 =?iso-8859-1?Q?spEcSElqbvHiRH8da/6EoT9H72jIX6Cjvvi3gFNa8PVu/yEoCmb1uhbm37?=
 =?iso-8859-1?Q?xip313lBnsoCmiK+v3SAl4XR//V6LJvm4sV+4nZ7mVcpnrBW1cOX4pPEHe?=
 =?iso-8859-1?Q?C/sgoj3YnaaBPoo8R00eWoYccVcvgRUIxiyyBsMVdMRWzW26YW4shSNPV8?=
 =?iso-8859-1?Q?CtwIsiOH0KzIJTfAayk/9JFxMlgOXnCvmzy7ijrMzrs2gIRfusTwDcKAX1?=
 =?iso-8859-1?Q?LW8idTe6qbtFN7sEl3bEbPiu0x+FOvDetOB+pGynxJsAlptNaBfLBlSg+Q?=
 =?iso-8859-1?Q?PnvR7GWOTzUQb7b08r6Grjl5vXE9CIEBWiOUFtS1pYTD5cZu0pvtGpf8DD?=
 =?iso-8859-1?Q?S0e3YRBswbTqfqXqI1Dk/w0qRL6jQDDM2LiYhBNhEXYIg9AelZ6SneSZ3I?=
 =?iso-8859-1?Q?TzHauScaMMBKJhxFJ6iPG2NUbNF62MAy3xkK9Q3/geGdMdWVvHPP9NOnGF?=
 =?iso-8859-1?Q?u++y2i8SiZiuaPnyEdu4YNucN62Irkescn6oRlMujWvQn8+HWzDVwL4XiX?=
 =?iso-8859-1?Q?+wNK+XDS4Dq1hU4ED68c29h7pKe8rF/IeHuo2BCtEJh8fTomxZdzmPao9r?=
 =?iso-8859-1?Q?QTF+MF5R+C92Ojc/hJpem8mIvYNZ4FFGksdYlk64lkrPiOMxaI7ZYLEaGs?=
 =?iso-8859-1?Q?kcgWU6iMngfGrnI8vZHYUdQE19W1L6dIDZKdQOIvPZImXUQfGNdQMTm7h0?=
 =?iso-8859-1?Q?2sQzrjRc5Om3SF50x5Ndx8a7HSx7rI2h43UonqJcrOtU8x/kd7oEEzSHmB?=
 =?iso-8859-1?Q?7ErcGon215bFaGI8iP1LMslK9UE4RKYPZKaH5V9oXLpIVw8R33P02Tz4ZB?=
 =?iso-8859-1?Q?kpcJ03k2Qb2ZL4H4ZC7txxepJtjrfH1A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eS7dtnX0zN8QjY5+LDcnztQiNmjUjbsx995jyjkaUSe16W3AZ4kpw53uux?=
 =?iso-8859-1?Q?Xec6tEV0pNupep7mmOSxC6Lc+auJNrkEPg1y4dwV/fja8lT4vH9c+CsumV?=
 =?iso-8859-1?Q?S3h+HqLre6BSBUbaJLRPiraH11lCX80q/lNgwCmfWbpuQc+6Y4xLwlDUOV?=
 =?iso-8859-1?Q?JySRr2IKqZShsgOV1YoqF/LpSlY85p4ZbeXMjn1r64JrzSy1/j5fqNw51S?=
 =?iso-8859-1?Q?/nFxzcsqy9/148UZ357vCL6nEAmgN1+LkekONq4AjPWdsHLRcXBbinh8a7?=
 =?iso-8859-1?Q?hQ3iGpsr5pp2zGrgZaOjHjns/kxhdTLxvr9NTc+sQLqyM/PSPuBp9RPOHV?=
 =?iso-8859-1?Q?9Wn9IHetrCVEYBpwoLKLYJEkhGxF3eBeLlfUrs9JS15KL89WCmCdG3L6Ra?=
 =?iso-8859-1?Q?M/Dc9RdFutNjmX6NXgmp5JZHUXeLIkOD+FlbiC1kVvnstJdykFPNNJVgvb?=
 =?iso-8859-1?Q?EL8OdU5Oc9bp9DjLzGVbBqGTv5r0v79Nd7XUM537Kor7ehH3DNhMlZcCIZ?=
 =?iso-8859-1?Q?Zb2XTNaz/w6oQS9jlEPCvMspmTzw1F6DEpwNPs3UlybZQXvCyd3P8aTJJf?=
 =?iso-8859-1?Q?RmbB6uXEs84ArqgI8uOJ5DqFWcWNBe8EiZc4Mp+Aiq84yP29wxEcMYNBUM?=
 =?iso-8859-1?Q?1prvbF/wxg27rhwCOC8NO9RvKdnFYeVZSuiKLQC3kqhkq65thvbe6MsPJ/?=
 =?iso-8859-1?Q?c3EM0Gl1jj/+TQWqYx//HC3d/sUQrmFHmWwwoeWz3vzREHiptrlP7arLTp?=
 =?iso-8859-1?Q?TIF/vi7YGtgC6xOoyg/odwGtYsMpXgMF4txSDQKyLylSBCQQM/69dluqwt?=
 =?iso-8859-1?Q?dtje0a0ezc4yTjJ0Ece9tbhT9Ti9YZwzSq/irvfCy4H4lp3sWkWkSsy0Cg?=
 =?iso-8859-1?Q?u/ysV8AvMDWdD96KAovixVqUYvoVSP4BH61gogX23it5/quo0Ocw0dseU6?=
 =?iso-8859-1?Q?3M1Rn5tzbCKecy9PaqDXr1aTaJWBykUfmJftiiDCShqbjvbM248mUPsO72?=
 =?iso-8859-1?Q?JwxZ68qgf+KPq/02leHkds0L6Ef1oF/x75dIVnllCs4sAhVImbeOskdwDr?=
 =?iso-8859-1?Q?jE+AIlucfS0D7l20bEW/B/R1iTNQvWyQSXvmv46O758xUejqJUXFlspyJ4?=
 =?iso-8859-1?Q?Ljmtn1aJnWZ44i1iYSvk94s86fuKdFxse5MvCYt1YDB5sk6YkHF0h5QIbB?=
 =?iso-8859-1?Q?Fj+U7U6IWt1RWsaPTE6IbkMYU8J+hGXayoDOPK9Z0ZZ9ZfVFNRJyDc2tVN?=
 =?iso-8859-1?Q?btuJa2s4OYiNNZpVb8QgsH1cnHDDmdVChKZ5avUCqN5+hYeYqiidcWgq7V?=
 =?iso-8859-1?Q?Zh6zUOzqV9nG18vZ6EqTl7aYtqwiLkRDcsDM2hv+SGb86kxRCxo64SGoE4?=
 =?iso-8859-1?Q?+dAzx4JDI6cu9aMdJCnybOJj+mq44GIWotlbQYAhbaPmU8Y2oc5cbHtzDc?=
 =?iso-8859-1?Q?716SUb589D3znpMX+95LcecbI/L7Xmd/qpxxPQ2yXWRRBfgDe/laQwCl3r?=
 =?iso-8859-1?Q?9QBNIkY7n7aNGHRUV8AjsnIRLzTxFYtU9Pk7FWIV7lQE0vXd4L98RUCE0V?=
 =?iso-8859-1?Q?gRvIVSbSxMR1C8uTrOpdpImbK0ck+Sc+dZgbWrN8jb522bgNfWAd3YhFUt?=
 =?iso-8859-1?Q?JEkrDHatfCw+yk408zOcWsC5LgvhNTBsQ2kGhFrVO+Y6Q8fcZK+V6+tA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c79385-93bc-4a26-fdc2-08dcdef7a2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 13:23:54.7612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4FUjX2X0HxMHXoG0dNLPjhumXv1YLl68fSOLNK6r5ARlQlvee4WqkZFBg1X2Ah6G4OL6059z4TkCxTKEyQ1AMq4GDgTyj6HLUJaSTvrt2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB3371

Hi Marc,=0A=
=0A=
> Can you test v6.11? =0A=
Not that easy, but what I at least did was to copy the mcp251xfd drivers=0A=
from the 6.11 kernel to my 6.6 kernel and gave it a try, same result:=0A=
[   45.126666] mcp251xfd spi1.0 canfd1: IRQ handler mcp251xfd_handle_tefif(=
) returned -22.=0A=
[   45.126694] mcp251xfd spi1.0 canfd1: IRQ handler returned -22 (intf=3D0x=
bf1a0010).=0A=
=0A=
> I'm not 1000% happy with stable at the moment=0A=
> when it comes to the mcp251xfd driver.=0A=
I'll be away next week, but after that I can at least =0A=
continue testing and maybe write some code ;-)=0A=
=0A=
Regards,=0A=
=0A=
Sven=0A=
=0A=

