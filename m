Return-Path: <linux-can+bounces-2671-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB0A17DA7
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 13:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F9F3A331F
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3852C1F0E5C;
	Tue, 21 Jan 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="a8bZUxR7"
X-Original-To: linux-can@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022138.outbound.protection.outlook.com [40.107.149.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED81F2C30
	for <linux-can@vger.kernel.org>; Tue, 21 Jan 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461706; cv=fail; b=LJ2tur6dLSkcupM56UbKxBtDFtm8Gx5pj6NiIB50hcJU3kL3Pvx2rLwo0KuUqMeJzhTBf9/zNw4IF7gZ/UBF/9s0kauEUC7QrEWZgi0b9zR+Eo0TtEy5w1Jd824vlbFUMZDBWHANJxxRD9GNGXNrJshH2zCZBoCJRRMjCKoV0y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461706; c=relaxed/simple;
	bh=MS58hCgvZOK0e5O2HgqiXyGKQygm2zOYnclumlLEeSI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BBa4gDFGFoaRHpIEsJErh4BQ6LCz0mZpkz6iR6fLzeE0NwmVZZoVyiIHevkS2l1xL3zrlFvL38c/Tsy6JJjXAPyNbfRbn3wkyScTkL+xmTIT+b1rB2LwIPmi5VV/sl3s+Jx7Y4xc7FuvGcAcWHw2/z+beGYQrQv5D/fJ0AbKkQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=a8bZUxR7; arc=fail smtp.client-ip=40.107.149.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5doB60kQ3p6IBNCeG3bs9AAMZ/6urmLIrAXlFnG+IWqUaTH2DHpeSj/tV9cbgAe7qwLIU7gO0yZGanpjEoAHz5ODeyDZjB3pVF0MgFkVRyZ2GCJxwgLQjp7lFv/MLtzh07FFAMnWqHGYn+stbykXr3W8FJmbHMFd7hpG3qZ+63TEn7AbtSP7eLBPpvqxTzMIEQmJ3wQM9mmVFbATA7bUMQfi6R8Fl7ft79bSJnIqGMnMnc4I6vru5W2AhilvLR5CwWYQ7hMab4P9ohbk8xVMv/uDtoek6YXCWdK1VQvdgY3DmMIuCIO7AMnNwyqNogLrO2TAHRmpZur3tWO5QVywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RTf0KqqQKYy9gEMxeLb5vWxv1n2PiAV7X2pO8SGzxM=;
 b=KS6kqAqzry2oG4Mkr/BRPGfgW88/pcwQXZd3V/MfHc6pwngLRxsoMYoEZS5pou0wI0W4ZcKq4sUL/2pwAmeKmwLzZldhABJK7aR5JBJjb6GaZg/gKbW2y7C/MGbBtMnOL/m7IzQKfyJttaHzHgeSKVl0Es98KS8UePj41UKFaHHMI37Tox6uZ5VRwxaTvB4gUJegVXR3pN2cPohkrA+3toRPy03fkf8Jfyw4K0XksZxBRpKz7SrOAkctiHXf946Jn+K0z6uSH1DnL1TLrFvpnTuU1bDE/hPYRvdrCMA27u+aOxTFl7OhkgYLV4isOonQlw4yGc6fRIhwZAapsL+RLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RTf0KqqQKYy9gEMxeLb5vWxv1n2PiAV7X2pO8SGzxM=;
 b=a8bZUxR7xdvRCltAuyJogjENNRlMFTZSHJKiVIH5OGtSrvb8szInrqa+16QYyIPKL4o1gJzmZGCXqbprkqknq7e/aLi60UbuTNNLUbkdQtIojlVvJUWt1ubWGYJE2F5flKt1pilp/9czQ0iLKi863AL8TRkXIHwFeotHf/H7Gk8=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR6P281MB3555.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.23; Tue, 21 Jan
 2025 12:14:59 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 12:14:59 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Subject: canbusload and canfd
Thread-Topic: canbusload and canfd
Thread-Index: AQHba/0/6F/6NZUR4Ea9t80HFvTRPA==
Date: Tue, 21 Jan 2025 12:14:59 +0000
Message-ID:
 <BEZP281MB2245032053822A5B4303317AD9E62@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR6P281MB3555:EE_
x-ms-office365-filtering-correlation-id: 66a85852-aae3-4dc7-600f-08dd3a1539c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5We225Q91KFa3YTRdNPNnP23heGQ6HUh3dUm8j6K3/7ew8yMTAkbb4bbFZ?=
 =?iso-8859-1?Q?9ftcBM9+Es/JF46TsQP1dPiB5F08W3uRQ2ux9laJZt/tc3QQLfHql/ss7L?=
 =?iso-8859-1?Q?a7nDQfXXXvKdt9Si/j78vYkWlWVK+GGkzU1birT5mp1SXvvZaK0l8F4Dwg?=
 =?iso-8859-1?Q?S5zSUwG2S/6CxUCO2/4msPVd03uh9RTbAPDpWKO2ZT7KOcVmU5xTAw5hWL?=
 =?iso-8859-1?Q?lMNlU1922aRyuYdv+G6pUhtKK2jD2KWY9mryqKJ/HsfNXktDQ6YxzRxoSS?=
 =?iso-8859-1?Q?d7OwETxywuisnHzn3jhKtXr0wmI7Pf782vf1CuX9OtHtjhu26WEBdFyebP?=
 =?iso-8859-1?Q?fGvSNSUknD5tVPF3o0V/LMJ/hCJBwNd7h8qmPv34gPiyCF0mC9VPFh3x12?=
 =?iso-8859-1?Q?SmmEATlJJU35/8JlUTTE6Sgc6AGy8Gbsg0Zep16wkQqOPH3jIKmYTgxx8M?=
 =?iso-8859-1?Q?2nYTAxKAr5L699E8g5Te8JOBdAUVtvUmHvxKUeMc9r2wZ88pkfplIzJ4v7?=
 =?iso-8859-1?Q?KsXLy3Dvg4LwPhHZqk2QXMspm8IoEo43VOIXBOZo6h93VmmMpgYSLa2JWx?=
 =?iso-8859-1?Q?J5xUT58dzV4qA4yDS7HkzoMSm9SYAu6KEp2lwGeJd94CZcRBsJawEacbwJ?=
 =?iso-8859-1?Q?NoMkhqwPegu4Ui5CJmfxQFNLb862sNxKxvp3qA6MyDcf1SC8VEhqLzdnLG?=
 =?iso-8859-1?Q?7DEItDHGu2tlDZ1QNQcJzLdc+bqLpGkChqKb/I3BXcJ1mPOLe/e1zw/mjO?=
 =?iso-8859-1?Q?yptmE/o6UPjb6QpDYBt8dcWTXRLfFURZdRhNhfRoRytotve3ATsi68VXKS?=
 =?iso-8859-1?Q?7LkW2XCqxlAajb92kV3pyOArYUgCrHLErgW0rK8nI5d0kDxwfwlkXUEvuj?=
 =?iso-8859-1?Q?+wls8NOAr0oykSqepLFDsKZoMqVSYn6giIFW6QWh3wns3fbGxSFHx0L5+b?=
 =?iso-8859-1?Q?RuT3emOpXnQ0nGNuAcYzLwohlm15NSfOwQx/Z/4kO1PiYp7HrF+XJlDOOa?=
 =?iso-8859-1?Q?vqCLoA3Y0Tt5Y6GAjZbiIDem6zpFLtgXrRxHa9PJuG24JlZR6+x9Fe12gO?=
 =?iso-8859-1?Q?xIILiMLkdBSB3yHexPtKVASz1/xRdbiC7A/BM67vNkhJhS7m16nsFr/gZC?=
 =?iso-8859-1?Q?d8aJt46qa6nB+hP293lSumV4PJZb9kM/dZFOU7ZeaaZBk3wWiR9lM1QYeK?=
 =?iso-8859-1?Q?jllSYyeRe8uTMwUEiSRc2caMc8NZVgfAN+8wiKoeGFtFwS7sg4vPiBDrJA?=
 =?iso-8859-1?Q?o1KChlEHnpMN0m8chFB8BV0pvJNxiypnrZjMGA1Fsuno+P6adI8yDiGTZs?=
 =?iso-8859-1?Q?MCnwI+Sty4F4D7OLfyW74fxSir+hOrwOomMpoCejeEiSlm0pr5oWtZUng3?=
 =?iso-8859-1?Q?zIQNRpIaYaHCVoVhdvvi1ceSMwUOx1Y8oZd9m0Sv/n+X4JcLnrr5maJ42g?=
 =?iso-8859-1?Q?GcOqRkaWvlZ0siawb7wdU70YnKsnVLvhLO3dMInbxuDmIOGMh0s90c1HEj?=
 =?iso-8859-1?Q?0bTsfDqr6fIkOr1Pdknh3h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?X1LfOz9nTGkb+ftHReFdVPAD5/DqaT0bkUNKPX/7FrLxJMC+MaxR9Fo0yc?=
 =?iso-8859-1?Q?6Ug8s1BdBXYPW5UTEGHU8lOjXl11jDZPn78tbdcjFpeNzDddmEIQVyB3g6?=
 =?iso-8859-1?Q?9ZGUsA7yyBvHmgwJCl0Ij3i4uOQ1W8eR7KfPEDWdTcVVh+MnCNX87gNneV?=
 =?iso-8859-1?Q?DRQpIHD+VT/Zid1TaD3y4kP7/+KkitZ0UyMsrMNLsMoCTFzpMVeSDwYY+y?=
 =?iso-8859-1?Q?P58egWIhdCNcP75nqHPrR3UGleMVqy8ENFaKEbXxU/wGiaOhFsRRJhy9BY?=
 =?iso-8859-1?Q?tV6c2KG4D7TqrHGGwMRAQoqU2dALS4SlCS5Muigc0fqsaOC38gA4bYK7Ne?=
 =?iso-8859-1?Q?t/ldBLBz5n3R46mNK92LrKt0PV58wOSikXFYOkqeVF2D7HqVm5PF4XoKbJ?=
 =?iso-8859-1?Q?dVKtmQ2pXGpmbkJsONuahTP+7N8PKV0b7xCKMMOdtYZkFu2q8YhDpg3TKr?=
 =?iso-8859-1?Q?/aMO3/9FYouW/NE16uy6JGz0x3qgm58OrHU9l7FPGvNtcsNoqaR3ROHail?=
 =?iso-8859-1?Q?Y/b9jWagTLO+x7nOTenDH9FQ+6noTBQwViAOVr53xPDPP+FZu1FkreplWH?=
 =?iso-8859-1?Q?WCBQ4nGzM89FnBAxEiwK1DAs0yfvcam1kM1/kz7n00BBgm4YAhsBc7iA9T?=
 =?iso-8859-1?Q?DjMxcPJN9U5NJsNMgVZwNbUO4UMo29vV5fBY39RMtu7N4yWAnadXEC/lSh?=
 =?iso-8859-1?Q?meCI4ZG0u16jpJCGa+RD/CwD23ThZaGgxy3DeLPmWwhGtlJom7y5C8D8Gc?=
 =?iso-8859-1?Q?gJznlJOmfSY+e1wWSTxPieeXVIaDVAigCTf1EamIEvaHp/HN44Lq8TpZKE?=
 =?iso-8859-1?Q?oowRPto2+d3+jixQ8TRDYOlCaMSMgYQJKexgApa3DQnr/dwaERpzVGNXtK?=
 =?iso-8859-1?Q?++jWQFbyA9g7vuL9oUYATOfZDrQ9LqcGltb1aq+L4g4LDe8CSmf2XPI6Gn?=
 =?iso-8859-1?Q?Br9iDGFOlkmKAh3TLCCRANLN75iBXLPMlSVKI97dMhcYfK7JUCS0Q3f7Fe?=
 =?iso-8859-1?Q?MDuuNiTfEab77J307H14C6Wo6Zk7CnRomvx9Jy1l5orz9jhLZOY2ZVufYY?=
 =?iso-8859-1?Q?dvqP0Iou7nWnQUHwAGuhKBLK5owOj2k7VEwo2/IwAHLL/l9pHSmgnZgEa7?=
 =?iso-8859-1?Q?vm/vbW12E9AA9ckTSE8JLEb65vuKGSOgZ24X6RqDK2k93dy3pBXc7Fyg0+?=
 =?iso-8859-1?Q?lFDlQucpbsCsY3ugDQzCpwUYDyfpGKP2zg0oqp4nq4D6SQ6otjv1Nf7VgH?=
 =?iso-8859-1?Q?EIrqm24y/upec6g/EHdHg/EvGt5mcYV/TLT1HbhHU0E5doEOWx0wvLaMH1?=
 =?iso-8859-1?Q?cZ84icqOinzzfV8LftXbQZyCg25W9edHyt9dG/gIPdlU3yCplQQsWfpMR7?=
 =?iso-8859-1?Q?01OIfN+Neq2dp8gnihZubu8/RmIx2hnj3Cz3adIhVVlsUIy9CylL3YDzvS?=
 =?iso-8859-1?Q?t7zGw64sgF2FOddQ1HF8kE3lr+mjXO71MElZVrRdwhfcmpiYwhD1INeooy?=
 =?iso-8859-1?Q?ux5zQqhA3SP9Oe5XtgjTVMAe9MkfZwg6cTlfTSSUH6FSIOwJVRqys1mWuS?=
 =?iso-8859-1?Q?sh5uNBRoVruR9BAMqe35C1Gcsc9CuD30akEgOoe5wqKhpTS53s2BHY3WbB?=
 =?iso-8859-1?Q?TsEGVE1U8zZkBQdWLPWUU8VFZyy4rbw954wkXh5R6arHVlBs/lbyZKNg?=
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
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a85852-aae3-4dc7-600f-08dd3a1539c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 12:14:59.4351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtIzxaaKk/nb8dRZ/+lymHucf0cSqJAuDVrfBGNehPKCbd8HvRf613zW5FEpaiZlK0WCxHt8xXicRQFW/qRddRC1lWZjiIC40MqE8yCOkGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3555

Hi,=0A=
I am trying to use the canbusload utility for the first time - ashes on my =
head :-)=0A=
=0A=
I have an canfd interface configured like this with some traffic:=0A=
$ ip -det a s canfd0=0A=
3: canfd0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP group =
default qlen 4096=0A=
    link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0=0A=
    can <BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) res=
tart-ms 500=0A=
          bitrate 500000 sample-point 0.800=0A=
          tq 25 prop-seg 31 phase-seg1 32 phase-seg2 16 sjw 3 brp 1=0A=
          mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_in=
c 1=0A=
          dbitrate 2000000 dsample-point 0.700=0A=
          dtq 25 dprop-seg 6 dphase-seg1 7 dphase-seg2 6 dsjw 4 dbrp 1=0A=
          mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_=
inc 1=0A=
          clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso=
_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 pa=
rentbus spi parentdev spi0.0=0A=
=0A=
If I do "canbusload canfd0@500000" the output is nothing.=0A=
If I do "canbusload canfd0@500000 -r" the output is "canfd0@500000     0   =
    0      0   0%"=0A=
=0A=
Do I need to give a special bitrate for canfd to work?=0A=
=0A=
Regards,=0A=
=0A=
   Sven=0A=
=0A=
=0A=
=0A=
=0A=

