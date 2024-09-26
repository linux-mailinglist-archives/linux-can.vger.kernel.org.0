Return-Path: <linux-can+bounces-1569-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF3987973
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 20:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C431C21F6F
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F47313777E;
	Thu, 26 Sep 2024 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="KhJCfQJg"
X-Original-To: linux-can@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022126.outbound.protection.outlook.com [40.107.149.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5D4A24
	for <linux-can@vger.kernel.org>; Thu, 26 Sep 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376747; cv=fail; b=YAT9U1BBKR9IXQ13cKgZ5Fz9T3HjikG7lii7OUPjz2GKKAktoZG/yES+em+Gcm9FX5yLUEf7BmKOcdYAkq7xmw67bdNtGRKt/VS5bq3YQGjirlODUftAOB59/yoJ6UcpAi5y62+mbH+PzkEy9vKb+QnfBc1sSfUr3AdMx4w+0MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376747; c=relaxed/simple;
	bh=ejLGua8l5oPBU163v0lrRGKk57spR0UzTromUwb2XhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Brmm+FsKVMKtfqNwAvWzMgbJhLSHJvRIwTxsoRe7Iw4gDeaQmDwh3+RkFe+PwheHwLokFZu6ZSY7Yy8Vn6izM9GamtKoE44CKemt/tv+ok9CcUBxiNxcYGp2wN1h89+HozBaHwI0CBZe6MjQtHl9S8zey2j8NfoescpCuCGzVB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=KhJCfQJg; arc=fail smtp.client-ip=40.107.149.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLpU74XgS6/4BCZgbCPgksH+DGhtRSS8Li40FE4i32ZDAX/unKLtvdb34MNKHCVLZRsod3d6skKBuYnh/msq+I2TpxJgHelwq+UwuLHCKEcxclL8E9BYcseq5qwCzYLGxLNCOTKW3h4rXlQCgNP3Vc1ORtj1gIs7fHbX/f4r9MZD700fjjdhrbIcVq7T+7m43Rk4g4MkDgiCjiK3lMpsCxgNyNTQT7NgUT6syt3YuZwabrArsgtwu3GnvcK/dgxDlP4g53AyuJA4hYIg0LwaMB1w76lea83SXZ6KGK0PlfSQR4bU4WKVo8tX3x/vtKjDLoDBUyBkhrFJFw83ObyGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAYVR+hnVjuW718ogUw4Ig8rTQk8nyn5XGroaVhZENY=;
 b=QtqXOZu/9ZWxG5SZhrazVHwEdVBG8Br3APrWGNgexWOdRAEtGbZOhquW1/qB6w15Yr36DrWNkU+syC7hVV1WB2rYZw1xqRjrrQ0smy8MHC7Agy2y0Ed2M/v8e+7VLioqUZb2BFumivQjAlpcjf9z2WfGofKK3l93UB5YKtapihu+/YjBj3WXmmumAVR9NrNI/1fEW6uyFPwkMZr6gI0kRV9ygEW1zpW93iUzhy8a68mCcZBSaa/5aE3Bp3FIXECA6kJGCxDDPYYT5HG66BimEWQKXgvdoMyocPqMU51wRnnmBxs4rsC3CZ/NWxE1M3ZaKyIJrKaHDH0nmJJXaeERTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAYVR+hnVjuW718ogUw4Ig8rTQk8nyn5XGroaVhZENY=;
 b=KhJCfQJg+b1GcriKSq62smWCFZ15Nvfj8QtAUp9aheVyPr+S3SxrFWks644zPezl54EylabX7RZrbTbfY0q5YwDCODYTLB9LcGRLLzMBYXNU+ejLjn7vjDffZya5sVCjwgIz4hqM96S+slLwsQ4Xy7yXyafw/urxjct/rdZTZSI=
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6d::6) by
 FR2P281MB1560.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Thu, 26 Sep 2024 18:52:19 +0000
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fba4:515d:ba88:16dd]) by FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fba4:515d:ba88:16dd%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 18:52:19 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Thread-Topic: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Thread-Index: AQHbDxyIwLNmNNZaPEKJQg5t9sHOZbJokYSAgAGdlPuAAA2pAIAAJqvq
Date: Thu, 26 Sep 2024 18:52:19 +0000
Message-ID:
 <FR3P281MB1552B40D19AF9DE8CA8150AAD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
References:
 <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
 <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240926-pragmatic-colorful-lyrebird-dc8068-mkl@pengutronix.de>
In-Reply-To: <20240926-pragmatic-colorful-lyrebird-dc8068-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1552:EE_|FR2P281MB1560:EE_
x-ms-office365-filtering-correlation-id: 2f2a8a77-eade-4a7f-191c-08dcde5c5969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yZF3aLK2WGurVDTVffThkdscROJNmYVULJHO9uVHl5poFTclThQwoN8ecz?=
 =?iso-8859-1?Q?N8Od1hHhUjlpD3mcrPglHdA/Gf9TwHdMUhMPLLAZEry3nMl6C6lzsHB1Yt?=
 =?iso-8859-1?Q?AZ+/nN6O+l8MDcZmOKE40MvCJdFbvEbo6S8aTSY6FZ7MK8i8KdefPkjaY8?=
 =?iso-8859-1?Q?2K3xbDEcx9LV4J5/if6fz+s1mCbNgsNymPrk11A6vPUv+nP+azCWiS8XWG?=
 =?iso-8859-1?Q?2/2503lVwTA6jyiEfbvCVc5F7OYFtnwd3sX10BGNwEZZzmvfty4vHv1P14?=
 =?iso-8859-1?Q?VwMjJ3Zs3XeBkx51CsnQoaR5fwZlPtnwqSszwEZ6F6CxvBFgyOZqnWdegS?=
 =?iso-8859-1?Q?cqtXEhmjmyWvNgE1lJEJZfVzO9gPZufB35LiPPqUVQxWLk1kxDKL9Th6Vp?=
 =?iso-8859-1?Q?MguRiJcf+mNhPmZx+WFeOi5XB3OABId9/PaiaPj7g+gO2D8O6Wmrk00l6/?=
 =?iso-8859-1?Q?KaPpgnQTu1Ujp0F0flFLrEWBPLwvtDFPP8n9m/zBjzcRsPnCB5fNFFfWwH?=
 =?iso-8859-1?Q?nhd9DhJNrfO+2dSCoB/jU+nxSgOvDs1x87GbLSOU0KyuNL0XEZbw/3+DTw?=
 =?iso-8859-1?Q?YrftL/RDADoI3wWwaR6LvQxxWtOOZNvOwe2Qfvwi8KpWCcxOt+xXi8yfCN?=
 =?iso-8859-1?Q?LuiFwfPs3tOlbzks66TGvNP+z1tegjW28L7aYHiDlkDa5Oe5Gr74Y3jxGq?=
 =?iso-8859-1?Q?3BHpGcYtSKBk7N+roSw1SsdSOVd6fEpI4KcB1fnoEkxRld/6sOPv/i/7Zs?=
 =?iso-8859-1?Q?aCy7zg/FWP8ri/K7QJjzeUEcQZ0r3fDQ16tsxYzdWqVA6MW+1t8L2OKAk+?=
 =?iso-8859-1?Q?51sQymMZ62XweKhqOKVJnr5L7aQUxEtKvMwYGg3DbhJFddCae9h5xReFrd?=
 =?iso-8859-1?Q?o4MFNCpbTYjacCNVwcLjm7JiGuCy4ThQahlLzREsdH0xcXsktVmZchbILH?=
 =?iso-8859-1?Q?B5VvM//3genMd18VOO8qybJRzGTDf8SBr0mCUeSJh+QFExzzuYxOw7Huov?=
 =?iso-8859-1?Q?lSwAY2HXJfCneZu/zEXjeY8WlzhTt4BKN8V0OF35EGIsRvkee5GcZXWmsp?=
 =?iso-8859-1?Q?6RprE2+iU6ZnbCTss307QUekSrzFTPUUAmDROA59hV9tsbp4A1uw6y/4bx?=
 =?iso-8859-1?Q?CGSHBqj8+KfaN4AiGwqrJDwR+tVrmqh8rp4WiBe6zDjs5cGgGhCBXSMWuL?=
 =?iso-8859-1?Q?sk0XJ0geyB1kMMrdwB6lJILxJt1hAwRVKrmkfogD8aov7zBf8bpGuka7ja?=
 =?iso-8859-1?Q?TzCgTI1DmwNIj9+vwyJOqAaqjKzLjzm7PsBJFdlbO85M0Gto/OwaWS9XL9?=
 =?iso-8859-1?Q?V5lsSBurzQGn5JWvQs3WVkg4JjqBSXFkZtH4XrqheCxNfpGlhdzLrIvOnA?=
 =?iso-8859-1?Q?QuSB1rxeWrZ/iOFU3DJtqXcSMqEi5g3A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uYmNiSwROvUun9MTZEo4d1ldDg9+Xjzi/GWUwv1LQz33cxF01vHVYULVGP?=
 =?iso-8859-1?Q?Xsz63uvBDqqyNNYoDlE6RQ8bpzhO9yAvlWxHIs3SltC/V3VG/WD9OsqMtv?=
 =?iso-8859-1?Q?RUCWtBMLlDkRe94J5TalCHYmirRF8E3FlIe0ZNBE+GIqCWKp0dTTEgUcNr?=
 =?iso-8859-1?Q?1tkA5lOGeNOCefPaTbl7wxZLlOUYBRNm8rGr/7//pWrSHvxDlSP+MUPrNb?=
 =?iso-8859-1?Q?+KHi2+CRO0yctjPVACQlTOsSC1e0YPJqzauDZbc/JsFMz7ms68stiz2eMp?=
 =?iso-8859-1?Q?HaHRJTA1wwpMR8yumrHKth2vv88YpG8DvEVC6PUzT71b0E4ZPpOGgFe4M/?=
 =?iso-8859-1?Q?DKX39iuPU0d8+DFwCOejgt8O1EqYmUSBZ8j85E6RBtzsjt1oZKqZQ6aq+H?=
 =?iso-8859-1?Q?9tPAn5hIasIvCdjl3zYONfvGNA6vPI+7RfoOIVnqY19SXnnwA0ykDvBRKd?=
 =?iso-8859-1?Q?j7xgcvclJNAn55FPP13C7o5qGTaJBrgsaFtmnSg0UYEU3td4yBLtXNNXvB?=
 =?iso-8859-1?Q?UrK1uaS65Rd5B8s41nwI161nrfePb5RJPRqhWnCCzNd4ptUqJSfeRTyPUE?=
 =?iso-8859-1?Q?qqNDThYYbapf0Ng0Zcv+ddIioivNM2aqxu9Twp7WVPf37AdIHFS+FqaCPX?=
 =?iso-8859-1?Q?X1Y0v0xRvky0n7DMRHBtI6jpfwoAsU2NxkcDc7ZfiPMFxGkbIuQlB8y03/?=
 =?iso-8859-1?Q?64q9FZPRHtcU4JXD3kHfBoApIlpYrRw0/SuhCrWgjEe+/6ngaAmwPhcjnC?=
 =?iso-8859-1?Q?hFTRyYPgKutcjReBeff0FEUOr/Zcp/yf3ZoNnmVYJkxenZyX0B0SZX2wK5?=
 =?iso-8859-1?Q?Y71vplVUVwuNNgv9a6HRCCEVdPuDH95d45S50rQVdu3xvrIrQiCfQsorV0?=
 =?iso-8859-1?Q?Ya/cVtKj4Wytfn1ArzZDgd4pz1sJ6vtPYUzvy7mgCrLdy/0ljNoZI1Jubh?=
 =?iso-8859-1?Q?KHrFvO/oxEefNoxrwDvs9lfJy3j4l4IlUi5icuqb726bN0gfvBtA7QUp+F?=
 =?iso-8859-1?Q?0Gifdo/vcwd7/ndsfSWPwmNJajh9uCmxPo3bUROlnd10Ygv1GGT1UjM3QT?=
 =?iso-8859-1?Q?5GZaF333oixqTWs2FcV5oi1XE25shCzZpAYvkKe8/z43OAOSwZwmmMaL2D?=
 =?iso-8859-1?Q?LdmciGsNWk2zNZ4xI/Gkjc2nG2FU9QwIWHiVCGLRSRFfSAM8+XYl3cSCNX?=
 =?iso-8859-1?Q?fA70tuAvn92gGVZDYzKuR80CgT86UsCNtfyDXDviKmiBzIuuQskmYii2SQ?=
 =?iso-8859-1?Q?1o7Ej4aa7NkspwYz70AG1pR0Xwsquv7MzYl8J+4uhwUdZtQvFdZZ1nJ3XB?=
 =?iso-8859-1?Q?ThHxXIAI324xI4RAHloVpengRZ/SeAs2Bqw4c+5vG+yESMjTdLe3b29USt?=
 =?iso-8859-1?Q?CY70Rb/RD8T8796VBYctbdf5zcsNkiAWzSbTkzEIMk0QSMUbRmd6Ahg1+a?=
 =?iso-8859-1?Q?dvLfWN4vrlfXPVJh+BjWxLJljiwuLC8SN54CmV+Fkv1k2D/D3rt9uZ10Z3?=
 =?iso-8859-1?Q?RSFWGM2JLaq9GJD7ga1+watV8vO9TBMSoZ4sY3c7Rssy0adADBTn1r60/k?=
 =?iso-8859-1?Q?FDV7oZfIPuLbHKvxhSqYxw7Mh/20ufAS9PvsiO820wKVi4aBEAznJrDtXG?=
 =?iso-8859-1?Q?pqbGTnhL1+JrHMnHBb5WPIyUcJycjZayQusXTUb4gXKqqvCNksTnv/PQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2a8a77-eade-4a7f-191c-08dcde5c5969
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 18:52:19.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekKL0jU7nlOfzmXLIaxy97kk21ttzKqmiBCzKMpM8pQaGrIdPoZoCBhxOV+ct0ZdM0ysuKm+Yj0bmmnxY5HlTs1kQ0h/6lsmnzJwqtLdP4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1560

Hi Marc,=0A=
=0A=
> You need these 2 patches:=0A=
> 51b2a7216122 ("can: mcp251xfd: properly indent labels")=0A=
> a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() in=
to mcp251xfd_chip_start/stop()")=0A=
Finally I had to modify this one a little so it applied...=0A=
=0A=
my observations so far:=0A=
The EINVAL is returned by =0A=
err =3D mcp251xfd_tef_obj_read(priv, hw_tef_obj, tef_tail, l);=0A=
inside mcp251xfd_handle_tefif()=0A=
=0A=
I modified mcp251xfd_tef_obj_read() like so:=0A=
=0A=
	err =3D regmap_bulk_read(priv->map_rx,=0A=
				mcp251xfd_get_tef_obj_addr(offset),=0A=
				hw_tef_obj,=0A=
				sizeof(*hw_tef_obj) / val_bytes * len);=0A=
	if (err) {=0A=
		dump_stack();=0A=
		netdev_err(priv->ndev,=0A=
			   "Offset=3D%d, sizeof(*hw_tef_obj)=3D%ld, val_bytes=3D%d, len=3D%d).\n=
", offset, sizeof(*hw_tef_obj), val_bytes, len);=0A=
	}=0A=
=0A=
and now I get:=0A=
[   45.672211] CPU: 0 PID: 1643 Comm: irq/47-spi1.0 Tainted: G         C   =
      6.6.51-pi-v8+ #3=0A=
[   45.672240] Hardware name: Raspberry Pi Compute Module 4 Rev 1.1 (DT)=0A=
[   45.672247] Call trace:=0A=
[   45.672254]  dump_backtrace+0xa0/0x100=0A=
[   45.672274]  show_stack+0x20/0x38=0A=
[   45.672284]  dump_stack_lvl+0x48/0x60=0A=
[   45.672300]  dump_stack+0x18/0x28=0A=
[   45.672313]  mcp251xfd_handle_tefif+0x360/0x538 [mcp251xfd]=0A=
[   45.672349]  mcp251xfd_irq+0x410/0xda0 [mcp251xfd]=0A=
[   45.672373]  irq_thread_fn+0x34/0xb8=0A=
[   45.672382]  irq_thread+0x174/0x260=0A=
[   45.672393]  kthread+0x11c/0x128=0A=
[   45.672407]  ret_from_fork+0x10/0x20=0A=
[   45.672426] mcp251xfd spi1.0 canfd1: Offset=3D3, sizeof(*hw_tef_obj)=3D1=
2, val_bytes=3D4, len=3D0).=0A=
[   45.672450] mcp251xfd spi1.0 canfd1: IRQ handler mcp251xfd_handle_tefif(=
) returned -22.=0A=
[   45.672459] mcp251xfd spi1.0 canfd1: IRQ handler returned -22 (intf=3D0x=
bf1a0010).=0A=
=0A=
len=3D0 looks strange to me here.=0A=
=0A=
This zero len is coming from inside mcp251xfd_handle_tefif()=0A=
err =3D mcp251xfd_get_tef_len(priv, &len);=0A=
=0A=
I also modified this one:=0A=
	len =3D (chip_tx_tail << shift) - (tail << shift);=0A=
	*len_p =3D len >> shift;=0A=
=0A=
	if (*len_p =3D=3D 0) {=0A=
		netdev_err(priv->ndev, "len=3D%d, chip_tx_tail=3D%d, tail=3D%d, shift=3D%=
d\n", len, chip_tx_tail, tail, shift);=0A=
	}=0A=
=0A=
and I get this:=0A=
[   54.645392] mcp251xfd spi1.0 canfd1: len=3D0, chip_tx_tail=3D1, tail=3D1=
, shift=3D6=0A=
=0A=
But I am not sure if the len=3D0 is really the problem..?=0A=
=0A=
=0A=
> I've already send a mail to stable to include these in the next stable re=
lease.=0A=
Perfect!=0A=
=0A=
Regards, Sven=

