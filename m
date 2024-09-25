Return-Path: <linux-can+bounces-1559-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A8985452
	for <lists+linux-can@lfdr.de>; Wed, 25 Sep 2024 09:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979091F21898
	for <lists+linux-can@lfdr.de>; Wed, 25 Sep 2024 07:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54631157472;
	Wed, 25 Sep 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="GsmiF/sV"
X-Original-To: linux-can@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020111.outbound.protection.outlook.com [52.101.171.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27440157466
	for <linux-can@vger.kernel.org>; Wed, 25 Sep 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249899; cv=fail; b=W0KZ8kgWQpvvaGqRA2B1Dgdj5Chdozk/yw9Byq4WFKxHBJeBAzaEtJRSK0d7IU72frBWi6rD+7fk5tprj1OpcF/WPYXBl8IDSshZliIqUfCMO0H+i42whsatB0UH6SCkCCa3rr2TZI+0bkqipvcucZ3JpkcVdAH/hG7OGZEf4Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249899; c=relaxed/simple;
	bh=39yQtd8Elek3GX86XQVY6PSIb2QTYb5u4QC2HVsn0nI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nNdXNu0eYiu+TBc5CEGlEpl67HFhyXhB/BO3WXjPcl6bE6QHQuvj7adoiEzi9x2ZO0Lx8Dr0yCMpRVMq1ra8Suj5g83sv3WgmEnM7tts7cTWuuVWJsJ3vUWdC7rQdaK3PgLipDwGSLiwUQVWzAupVvYErD3sGWXEOjv6R8dAnp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=GsmiF/sV; arc=fail smtp.client-ip=52.101.171.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZxYPY78AEa0JfimFb5CpW/43HZHafZ5uV1sVG09+8HFzbbXs3DtBPjnbt0IXHxUdcRm1LI4Ae+rhvqd1cyjL4k+DRIJq9LVAB5MpYUL2QWaEdVU7S9j/4vwLeEpDpva3PP1TnFtkA4Ve0JmgJblkF7BSAJOnkwh4Hrbzxt4OS0qF8GMj8AzH/UxwAA26mQkFz2CD15ayNfhyyMJXuE4+W3P/F4jaNR7oQ8CCvpdYe8zeiq9yZysTuiRxglfWVmwA+knhED5G+WvVqunPNrSruT6/efn+SgXwFzAhtubcuxXY29HJy/tLJPKcfi1xbgh2hTIZXnQj+Tpb0xXlbu6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wDXZhT+qIqG77G+98s8qsymPBSbGTANT7sFxFZAay4=;
 b=MjwqafGOaoOhF1okMgXMbfLZzuOCNj+HYdqsLC3lzm+xb12aGbYYXmuwW1i1oWTWLSOLCv3mnTdwNnh+9a4f8qg0chtSLJjQF9ppDfgREV+0A/pz5NPS0UGDs/JWIP3ublqJerJjxrGKdQsD2ENqqkhbW0n9OrCHV4Rx5gybBNWTbAcaNHM/WvL7o2uIphtYLFUFob9Ib+T7EjOEbmRxyiJEtyctBPDzMShwDBJKR0tPJ3EnTIKLnJgoYa9NO8igjHkpOaFecazfe94l2cOApmUvMUPXDiWytdeX+fOMiJpQixrWZPplWIvvWD3HG+aupM0TJnegH7H5XcOE0SVl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wDXZhT+qIqG77G+98s8qsymPBSbGTANT7sFxFZAay4=;
 b=GsmiF/sVgHJnsHgxjLf8manl1eq5KwDd2tN5ilf50TL4Z79vffNR86lsuOgaMtLuQ+QCcZsTAk/LeTsppUPjA3PmboqoelgvUJfODtvs2mTAhWvmO4IzcgvNk4RrGmcBmT5xrXgXxIgCuJwZzXFyRUQHgi6U0sDqZtKjdV4WJH4=
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6d::6) by
 BEYP281MB4240.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 25 Sep 2024 07:38:12 +0000
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fba4:515d:ba88:16dd]) by FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fba4:515d:ba88:16dd%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 07:38:12 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: IRQ handler mcp251xfd_handle_tefif() returned -22
Thread-Topic: IRQ handler mcp251xfd_handle_tefif() returned -22
Thread-Index: AQHbDxyIwLNmNNZaPEKJQg5t9sHOZQ==
Date: Wed, 25 Sep 2024 07:38:12 +0000
Message-ID:
 <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1552:EE_|BEYP281MB4240:EE_
x-ms-office365-filtering-correlation-id: 590a59fe-a2d1-4ecd-abd6-08dcdd350279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mGDNNqynOak9Z+spQWQhcqdNtykb/uftn3b48dwU46XUsopYgBIV2wmFaR?=
 =?iso-8859-1?Q?d7RfgEO8RyotKkGYU7pEy0ftEtuxTCMsHrrGP0U99jJ1j8V1UewTji270h?=
 =?iso-8859-1?Q?tGtdPiIekwpfYky31bjRVnHnLtSShcV1AVbvr35ChnWeEvt4PKmVyUeZq1?=
 =?iso-8859-1?Q?U3TGM6K6dLT90e0IkJ3fSv5+a395IpjDaKW4aMb5ide8ulOLxgHKytDhQ4?=
 =?iso-8859-1?Q?IoDoA0YsaKrWI3W8oofGc4jDqoFcouxNwiKEYZ3RZjJpgUyWQxLWrefs/3?=
 =?iso-8859-1?Q?jI0F0cbpMvxR6yLLdf8fA8fOYbzE29IN60ri3QnFLL9lQr7JlHUPKKfjiw?=
 =?iso-8859-1?Q?U6jMgaKOzCusDhU81zT9xfP21RyObu27DKUMbjncab7896T9sS8Utr8Bm6?=
 =?iso-8859-1?Q?0asLzrSUluxADn+JVAVsY/cLyV863gcDlylX6qEsuk0n5DTfSUGVSxsRiC?=
 =?iso-8859-1?Q?XN+iM50gd3nDk20N66bqqqOvwvdBPDqZ9MHbyMdq7mRQkOTbaDh7zZFUvI?=
 =?iso-8859-1?Q?RcTgsWGGhUJHu6V2HD3M6d4UhXS9RXuL3X4zFClZdMaoMd6pZzIT6UWEg+?=
 =?iso-8859-1?Q?T53XKkir7AZqdT+V3d99dE0k/SApVx7fRlaPSlnRCeI60gDaYI0SV2F7Nv?=
 =?iso-8859-1?Q?t1t7GnPxvBKEgrsk7fk/SlYJqnsIL6DIQdIZEry76YX+TZEBsBe6n7qZw0?=
 =?iso-8859-1?Q?ANN/TLcT3vq+pJHjsbh84mFeMdcbf1tsCj7R7OSRuoz6JwvMODiSpOabqB?=
 =?iso-8859-1?Q?j/EDH+df5y/NS6vbg4DZddWqr8O8Fsu/0as+r35kMxWPIdFjCLDt1yy/l3?=
 =?iso-8859-1?Q?Vy4wXf5xTmaGSPQGmTB8ACZss6zW/dEb8dYoeF9d+Z1INds83b8k9f9c/f?=
 =?iso-8859-1?Q?n9IsLOWPOQAW+rvLz4nXuVLg9RplmNmqUrL+D2P49CQYv3lsARNviwa0Xk?=
 =?iso-8859-1?Q?ecBBo2NZCLD5/96lgDfEYkDpGNPiZuljcSx1nOCNWOtMdXz/MHDYMrElQN?=
 =?iso-8859-1?Q?iHBTWxi54Wr/tYwmZyDAXnEg+SlrTgD9Yv6cZQah5kU+jYJ+pKhe5ogHIt?=
 =?iso-8859-1?Q?8HvxtXmDcgQWgfR0UEQPMB6vxht5Ix6rzaWEGq5lGnipIjRdRujezFBNwo?=
 =?iso-8859-1?Q?CjVdXCx+rcPZl/j9efpFUBt2QcTsCKd9OqNzLPBgOoyP3N6DjLJz21USCb?=
 =?iso-8859-1?Q?jvOXiyI/eviRnh/ZMwskG/0DDLhWrn9PEcw7bdkiZ57sZgQL689gBYTCn0?=
 =?iso-8859-1?Q?uGsu5qF8XM0wle/++UbcyxDMyaCpR/96oHHnneR0v8C1Rm3UrUTiVKAo5M?=
 =?iso-8859-1?Q?2XuyOg6JwPU41nQtB6NRaQFhaKiPJEUhwaWCkeB/ObrwcxM9SmaokyXDr+?=
 =?iso-8859-1?Q?Dh31G+sy+YGWDQ+H/9yn7z4PIOcfJUfg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KIcQg0Oe4jt4z55Mc7rDTlZ0H8gmxPZpAZIRxXnE0hsw6vdJNoGR8xTJUd?=
 =?iso-8859-1?Q?ANlOXwA52MvxvJhUmi83juh6cJMtmzWN8dbKEY4RpEMuRIwIhmSpUsJm8b?=
 =?iso-8859-1?Q?imIOk+v/mwUudisDZhcbFq9AqFU65ipTEGCs1zkjoT0I9o9a9zk8vDD2dn?=
 =?iso-8859-1?Q?UBBapbeRqaD2UfP7Qz8/JNNHOrO4eo+KGGsnjIg8WqyaBohEuEiVx6wjY/?=
 =?iso-8859-1?Q?QZP0i0CcXy3hmGaf4/cKu/NB5harw/pqCWYqcnIEIuqoxMueBtORKEHNUI?=
 =?iso-8859-1?Q?YTaHfFgOrs0IksY0N4YCiasKXFxyttyH2T3qFTQAuDsdWw1m5jx2ZrrIlZ?=
 =?iso-8859-1?Q?8XfxdAS3g62LEhXkC+6jKc0S7gB4yCFm8ZIHwwQ5e5zfsi5mn+OybyOnut?=
 =?iso-8859-1?Q?aA3EreAZMGVYh2E5QnYqzgSfbk3cusxjMsBbEO9s84fyxeYHrTaP3G704g?=
 =?iso-8859-1?Q?7cJSPXqP71fdtOF77yQLYJtOWwJoWgDQqayVqACUUJOLBOpbgYvRLZuiR6?=
 =?iso-8859-1?Q?LUJQMDDODStrsxN9RJap2l7dB8R/remNd3Td0M3x9dgR0wI8MMFVvp9a0o?=
 =?iso-8859-1?Q?0z/sa0H033onkWNLK/7SywJz1Z0niaBBcznKzhVWlKMRpra91/EEIzl9QP?=
 =?iso-8859-1?Q?Z3h6THykwdZNpqSRORB7RVvU4yA0akIkvPkamKZIs+cw6mkwOuUlYn2zzj?=
 =?iso-8859-1?Q?ucR6+w3Bf1p6mKJOp+6gpvhvL5CYllEMSIz8LtQzPwUq2XKXucSjIXgb4x?=
 =?iso-8859-1?Q?xHQ/0CgXUo3Mci9zwranel5L9yTuJ+8mBwfIzyalrmIJc2OUX8ZhCvEFC6?=
 =?iso-8859-1?Q?/+R7SdTxKyYXMwdm7NzCBByHq66a1e2it50IhZtnzMFlY2sjRx55/pWWWp?=
 =?iso-8859-1?Q?IHXFzo5iaqvaXrweqWdcdVJ06jejFarlYHKfygeDfEk02miu2vhwJbux90?=
 =?iso-8859-1?Q?BfpXPXBUCEqeR158Zbu9jSqk74rV5ButPiq+Qp0jltTEeYrIzWl0S4s2mr?=
 =?iso-8859-1?Q?RUwu9oexfLFgvOsDQ9f6/z5WjdZdoQ144kCrzds81Uk2Mx/WWhymkiUjIC?=
 =?iso-8859-1?Q?qZGPnLl91HUBcH35K6fr8kV4EzKSq8177kRo2pXsBkhCox5iKNOVXw9GDz?=
 =?iso-8859-1?Q?HE8cKnaEs3GZnO7v+/c6kcxc/tNPvAESSNW4i0MWkaeoBbhm/fyAjfEbLQ?=
 =?iso-8859-1?Q?JDhdeZa5m3JVrdOYrBIK/4YGTPjednaSQBvtbuDutkBeNaX567Gg4ozIbl?=
 =?iso-8859-1?Q?rT01lxvYLb/4vGx3YX1O7CMzbr66hRpv3fZAzqUjXRlRkD57swRP8UwB0Y?=
 =?iso-8859-1?Q?gLoZtDnfpjiGIivKaEANk2m9rZKYCv9lXvQXJk5AW5mDasIa1FesUZq6m0?=
 =?iso-8859-1?Q?7hGyohdYT4t8WJI9s/F2UQWABXX4wf6qGs/1tqJcdJ/WnFc3M3OjMKLa+P?=
 =?iso-8859-1?Q?lJXzuCBAvM3Nhq8ZM8JOVgPdUX3tJLfxqr+t/iTD3Rxzs4NOZN57pwLDnq?=
 =?iso-8859-1?Q?wzLmDswlzqAfmCvgSMO9rXXzRnBne1zqsFGXzCX4Hi2W+K7DxbxvGPmnOn?=
 =?iso-8859-1?Q?NtRBekpT1txV4HcV1fmd2OQGg/fr4tmosFBH5ag//6jM3IpMIAZnkJgJVO?=
 =?iso-8859-1?Q?6HPXqFKOVuxU7/kw4MwmvHk0Y2UlgtaxZWEpYowX26ZAUhrSavba3qKg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 590a59fe-a2d1-4ecd-abd6-08dcdd350279
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 07:38:12.3805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcRq1DmG1gNNtWY+dZNJ74v4a01ku8ahHWFf1iitMuIpIce+oZxor9R3/a1rhEeMMMZE0DQKQsplIVgMW5VdYSubBO58m0wHvpYQMjIwr18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB4240

Hello All,=0A=
=0A=
I am using Kernel 6.6.47 and sometimes I see this in kernel logs:=0A=
=0A=
[  355.728634] mcp251xfd spi0.0 canfd0: IRQ handler mcp251xfd_handle_tefif(=
) returned -22.=0A=
[  355.728672] mcp251xfd spi0.0 canfd0: IRQ handler returned -22 (intf=3D0x=
bf1a0016).=0A=
=0A=
After that the complete CAN is down. =0A=
ifconfig canfd0 down and up fixes the problem.=0A=
=0A=
We are using two CANs (both mcp251xfd) at the same time in canfd mode.=0A=
We are sending about 9 Frames each 10ms on  both CANs (bus load of about 35=
% per CAN).=0A=
=0A=
Top shows about 10% of CPU Load on the SPIs:=0A=
=0A=
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND=0A=
   5620 root     -51   0       0      0      0 S  11.9   0.0   0:45.33 irq/=
45-spi0.0=0A=
=0A=
=0A=
Anyone an idea on this?=0A=
=0A=
Regards,=0A=
=0A=
   Sven=0A=
=0A=

