Return-Path: <linux-can+bounces-7632-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODAIMBT1Bmo4pgIAu9opvQ
	(envelope-from <linux-can+bounces-7632-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 12:27:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A454D51B
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 12:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC76030CA102
	for <lists+linux-can@lfdr.de>; Fri, 15 May 2026 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CFA3D170D;
	Fri, 15 May 2026 10:04:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020117.outbound.protection.outlook.com [52.101.167.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028D3D333E;
	Fri, 15 May 2026 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839485; cv=fail; b=hcvSqwBtqW5Z00iUcHniiCNbqJnx/cKpf3G54g3Nl7TS/sFUE2F+YZGf6WB7qvOJDXuaU1OFoLj9oRCHiMjDJLeJcHBhnKm14T/JZlUsy5hOrBz6RN9OZCRjbvURHB/Ddoe5vnVmPNQxCXmsQQgKXkOZehMyKWORT50gkBgRGtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839485; c=relaxed/simple;
	bh=TSKPkeuZIi3VooYShcG21L7yHnP7OF6QGnuP7u0IRzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rv+z6KvwZHB5bcB7m+T+IMvY/wswC19W+3y54pirpenZYbpam3qEmSeflDYNciqV6pqtywEob8gqVcARRz7dTxXp+MYxzfPA/HtfjtRzCA3RfSwoIqYLAY9gQFPZdxKdY1XApF8vTkBwmTbf8De5v7+sQnCWTH2dxqQrom9HBnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peak-system.fr; spf=pass smtp.mailfrom=peak-system.fr; arc=fail smtp.client-ip=52.101.167.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peak-system.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peak-system.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZ+i5lf3aZTEH5cbJbc6Qxc6Bhc+O6w98IKBKsJKw83binIx8KlQH38u3Mx/fLeuA6H5inhKmew6r86eZaj0QLH3ssrqenL7bvC2dFBkgo3BfAjNbFOc+gCqIYC21kWZuOLnlPoy/p569ocb0tHoxzzz6HpGmxpBl1GHZpQ//m+8ZnFf/qLva42yChl0y6R5928buYVMJYELYNCLSUUXCic++urc2nvXr5SHMzNIhBKhrtJhKyOsxjnkUZkL6IJDIVxnRvJC6CGFEP8+Wx9PduTV0X5T7ZTWUrBn6k85LGSWuPtA9Aq3KSwg64tvWrn9sMcZZXBTrCSN8nOB0sIAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSKPkeuZIi3VooYShcG21L7yHnP7OF6QGnuP7u0IRzQ=;
 b=XeXyPtPjzBY3ABAV82EvAyVdUR2ck7QAS5W+svqmk7VKHUmi4JNYa1OcRTXtmH7iJgWnGrrB3UKQtHf8dcRgmHgXRLB2WgataJSEN/EY6zG2HFxAeKgBEI9x6dNqNSNlCJf/qbwtU+WWU4J23BJ7BQ2DDnPk2HByGpmKmChmOiOg3z9SGRbqB2G87piYRE9iC5as8042ityPj2JywkEQd7Uv0006pyhxt+mMfduS6E+XPQn4WjdnOy7ecnnx+ULTzYByWBIZSK7hbA+GqVCUfpHjA081xjdzvx2eMHeeeZVdn2hDakhnjJUCUl4jpEEDxQVAif7MUFXk7byJn71tkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.fr; dmarc=pass action=none
 header.from=peak-system.fr; dkim=pass header.d=peak-system.fr; arc=none
Received: from MR0P264MB4847.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:64::13)
 by MRZP264MB2284.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 10:04:39 +0000
Received: from MR0P264MB4847.FRAP264.PROD.OUTLOOK.COM
 ([fe80::caf7:647b:ab5c:e000]) by MR0P264MB4847.FRAP264.PROD.OUTLOOK.COM
 ([fe80::caf7:647b:ab5c:e000%4]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 10:04:39 +0000
From: =?Windows-1252?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.fr>
To: James Gao <jamesgao5@outlook.com>, "mkl@pengutronix.de"
	<mkl@pengutronix.de>, "mailhol@kernel.org" <mailhol@kernel.org>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] can: peak_usb: Add bounds check for USB channel index
Thread-Topic: [PATCH v2] can: peak_usb: Add bounds check for USB channel index
Thread-Index: AQHc4r5L5E/oh7i1tkWTXIoUnRpE3bYOwurh
Date: Fri, 15 May 2026 10:04:39 +0000
Message-ID:
 <MR0P264MB48472CFCC3E3E867EDE249DFA3042@MR0P264MB4847.FRAP264.PROD.OUTLOOK.COM>
References:
 <TYCPR01MB856782BAA657447E5EDDDC1FF0062@TYCPR01MB8567.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB856782BAA657447E5EDDDC1FF0062@TYCPR01MB8567.jpnprd01.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR0P264MB4847:EE_|MRZP264MB2284:EE_
x-ms-office365-filtering-correlation-id: a55e3d10-1f92-476f-cc9a-08deb269608d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 jlsF/eO5xMzd4EhJV/KD9Ghll9ugbGt/qRn/LQvZXeoEggb9CXBuOjy3KqDyTSAazKmEGMQqqfHC80wGBs0Ue+k78r9uhoQn2Ww8YcGmZ/Ivkh2DCy5kcGWbFnn1y8+M8+PWwVSxVjlJ1+KuoWTdK7Za32NO95+eeVvc+KlUjVLU4Q149+Zl1VXMutNj/bQG2B3Ywr5f+FPizBqz7OwmejKZ4Iy4zeB2oMKN4FgGdLDq80fzXWEjvWBLIKknuatDoNVu3uOwevleicJZ2prtILjPCADjQBvcI99uZfRcDgNAWJK2L6rSHM/++pEiQuNWCEPegRD2JbuyoEYlK/nGr+3n4DEab2mXYTK54ac+DUGCpzZ3vg2rCJtdDm9dz7eFuvkuoBhSuErywik5NW4nlWva88YlXUd3HF7t69wyH1v6nQrvpbq/dXwGqPc00h+t/Ii9Pla0crTCdp4dml9NOLi+8n7BnsK8CS4aQAweXcTQZlFYaZ3Sbxr3DjUu8ZBTJ8Z2n1zXPgBMODqJsnCl62I1RLrSu7Gcd4xPETuJ5zyX/EiUtAzMxgD00SMvzhW71kv2KYMS4ZbDxLTuKHNTCN6j8ZGg3P3CTjvEOSIvidP3TNsVYtUs6g20O2wsAm+AYUDbLLvChxZPsKRuPkWVSeB7Zegb2I6ITGvEZhKO1kCGBx4ZGf/AwPRYLtdckwoq2OhAEgR+u9IOH4iJeC1GB5IBwnvFU4lCvq5NRxArvgbgk00FxpvJrKAjXEpHMTA6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR0P264MB4847.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?xquKUY6/SR7YT5rI4B/QhnZYVkEsymJFlwi3FDeTWdrB1SU6g7qjSolZ?=
 =?Windows-1252?Q?9NWjRw9T5wvC6KTCz8BJAK4tecgUhQtPjJNo+4JW4YROzd2UZKBg+4xY?=
 =?Windows-1252?Q?IDRfaFC44md9f5/DxOFb4PxiHevmVGwQjy/q713eib8ytpXXt+eO1gm6?=
 =?Windows-1252?Q?z2zQqLId3/bJh7iEe9XblE0q5KRXXowpYy+5sp2DC/VNdhvqv5QAsvI/?=
 =?Windows-1252?Q?R0LIDozbEjvB3JK2S50BPmbAkpzgdjpMbjyOngIc0U5TvNH7Nt7rOGWF?=
 =?Windows-1252?Q?prkHuEuzM3IOsWW6efzsNinKhJ8HaFY0t5bmOTd1SnjD5kySpdmXHBlp?=
 =?Windows-1252?Q?1XaNHlq2hfa98NLoh33yozVo2VtkAVFbBQbJ/N9XYL8T6k59Z4bBIVd6?=
 =?Windows-1252?Q?2DjI+sgATyhVERqwSgxE4NFrK0403KHxISGQZSXMATrNeXxYvfVtQZ2p?=
 =?Windows-1252?Q?us1X2nNeCqTq35nSBjzwjtMsZj8oMjhs/Sk+7nIzAJDsSzmkflkVrCeS?=
 =?Windows-1252?Q?BOHhNuDwqAEfA6rpazctdtnKaFVSIDr3/OKkJTC9u49mdiePYA7yWCaY?=
 =?Windows-1252?Q?ZZ9Qia5pUiC0dYWtJznHWruj8PjXJd6TufDsGA4dtGOTaogK08pq4JFl?=
 =?Windows-1252?Q?/m9AJi8QgkhznC2sOcwXAnQuAnUs39xNGIt5mioWbKcvvUSvg8DQPMU5?=
 =?Windows-1252?Q?KOpHRL7IKojlbWBsMbgt14wyjOcVBu6tmBMEknoZiK2adpEhaDS8gDsW?=
 =?Windows-1252?Q?1EMMeWVwd1yBZTMNoIme8RLvuL7prS9RYBpua9eBQ2D3A9osTlSgonjf?=
 =?Windows-1252?Q?li9OdkfhuBg6WG2MZNAUz3+Wz2ZHE+Xws0wHzW/AHCltaNFj5MxMqgvV?=
 =?Windows-1252?Q?9zuetUymeEye97tcxKjR1SUhXZIQ9maF5lR+MKlZapem6Dl+N0hqHVGV?=
 =?Windows-1252?Q?EKiuf8OLxrkEghsglLg4SR74QpQvBuy98a1byZ1eqoh/xz/Wf0pEl5HF?=
 =?Windows-1252?Q?jGjCxNw46baNKZ+wCgQZURg6lKlF8etJ8nOBTMsLYPVJIeF1FaHu658k?=
 =?Windows-1252?Q?D55voS9TP+ATG0teVSO/WTFUrEQOuJnJ9i3MvOs+5agUlM6BddNxC2BW?=
 =?Windows-1252?Q?GxdIeoDcmYQdAPJIJ/Xb30WNTvoqkp5vtUBMKbkcSQ8mtpg8aGgP1weg?=
 =?Windows-1252?Q?HjfccVbIVZIRlVOYV6rHJx3q7AYf75TNF4a1aubeLTIrQfhNng5ccNOD?=
 =?Windows-1252?Q?476muGT+9z4sOt9TmBGpn7neejuq7tSVSCxlxFFgJRA5l1GWiKdZukh3?=
 =?Windows-1252?Q?VnI76fIaz+aLPn5lUtRTFh1Vw9EotKyKpR0eFDdjTRBHb/NUbwchb6l2?=
 =?Windows-1252?Q?z//ygzgxsZviTOnj6oMcOQyEob0OskgCcwTAAiCdSl5OeoqXv5l7QgdD?=
 =?Windows-1252?Q?s8E17vBPHc6eY6M969VfiS+DSu/jy7rUcR/rTS5hqBZsNLqtyiQtYdzA?=
 =?Windows-1252?Q?0isyMi2+Rq4R/8RBmnCAXQERCWxl+qP7pgVpibWhlqT+Zwsc1fpz/WL3?=
 =?Windows-1252?Q?EiEp5aPn3rSBvWhxa2+hYt8AySMdfFL+5Hlg309edwdKMpKQ96AfC0W3?=
 =?Windows-1252?Q?TAvu5xhu7ZFsOGRmtZsEOpHPZmYU0XaxoyKGai2AnpJkRWDIUI4KrzwG?=
 =?Windows-1252?Q?rHxOW1m1gTTTYX5aglavGZiA8aAr8zTPZJNcHosNuV2HUgXQ8xuYvIo8?=
 =?Windows-1252?Q?s5quhnZ89+Euhahr/2r59eyxpD917LCwH11OjE7xs3zhWYah+/O+LjQF?=
 =?Windows-1252?Q?yIrkJfkaqEkfvuVCse0EkNjRxtjUDv01jA4mzRPP33BE5bibAYlUWl9z?=
 =?Windows-1252?Q?WZLJw0hmOMXdgUli6bJGch2s6X9eBbTRvGpPoPPR3AN2syEmiESlYKOB?=
 =?Windows-1252?Q?HEdbG9+g?=
x-ms-exchange-antispam-messagedata-1: F14sCE9YWLde4g==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: peak-system.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR0P264MB4847.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a55e3d10-1f92-476f-cc9a-08deb269608d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 10:04:39.3363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7bf0cf5-d450-487a-a3d4-3f76b45c3d9e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +t8Z4Sz4a18oQt2Pcr9Rs49u5bBuwNY7Lk6vG7rGKIulOp9YY5P6yICYF5aTvBhYhKz1yRl8yfIbnKZkWFYcG1++8dAEW3/sjC5WHmmwVEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2284
X-Rspamd-Queue-Id: 292A454D51B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[peak-system.fr : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7632-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,pengutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.grosjean@peak-system.fr,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

Hi James,=0A=
=0A=
Thanks for the fix.=0A=
=0A=
I've reviewed the patch and it looks good to me.=0A=
=0A=
Acked-by: St=E9phane Grosjean <s.grosjean@peak-system.fr>=0A=
=0A=
=97 St=E9phane=0A=
=0A=
________________________________________=0A=
De :=A0James Gao <jamesgao5@outlook.com>=0A=
Envoy=E9 :=A0mercredi 13 mai 2026 11:51=0A=
=C0 :=A0mkl@pengutronix.de <mkl@pengutronix.de>; mailhol@kernel.org <mailho=
l@kernel.org>=0A=
Cc=A0:=A0linux-can@vger.kernel.org <linux-can@vger.kernel.org>; St=E9phane =
Grosjean <s.grosjean@peak-system.fr>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>; James Gao <jamesgao5@outlook.com>=0A=
Objet :=A0[PATCH v2] can: peak_usb: Add bounds check for USB channel index=
=0A=
=A0=0A=
The channel control index ctrl_idx is derived from rx->len which comes=0A=
directly from a device USB payload. The mask 0x0f allows values 0-15,=0A=
but the array size of usb_if->dev[] is only 2. Values 2-15 cause heap=0A=
out-of-bounds read, eventually causing kernel panic in the IRQ context.=0A=
=0A=
Add bounds checking for ctrl_idx before the array access in both=0A=
pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error().=0A=
=0A=
Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific p=
art")=0A=
Signed-off-by: James Gao <jamesgao5@outlook.com>=0A=
---=0A=
=0A=
Hi Marc,=0A=
=A0=A0=A0=A0=A0=A0=A0 Thanks for the review for v1. Since this is not a sec=
urity bug I have=0A=
=A0=A0=A0=A0=A0=A0=A0 moved the discussion to public mail list. Changes in =
v2:=0A=
=A0=A0=A0=A0=A0=A0=A0 - Use ARRAY_SIZE(usb_if->dev) instead of PCAN_USBPRO_=
CHANNEL_COUNT=0A=
=A0=A0=A0=A0=A0=A0=A0 - Use -EINVAL instead of -ENOMEM=0A=
=A0=A0=A0=A0=A0=A0=A0 - Add newline between variable declaration and bounds=
 check=0A=
=A0=A0=A0=A0=A0=A0=A0 - Wrap commit message=0A=
=0A=
=A0drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 8 ++++++++=0A=
=A01 file changed, 8 insertions(+)=0A=
=0A=
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/=
usb/peak_usb/pcan_usb_pro.c=0A=
index 4bfa8d0fbb32..5b1e3501cfb8 100644=0A=
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c=0A=
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c=0A=
@@ -534,6 +534,10 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_=
pro_interface *usb_if,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct pcan_usb_pro_rxmsg *rx)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 const unsigned int ctrl_idx =3D (rx->len >> 4) & 0=
x0f;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (ctrl_idx >=3D ARRAY_SIZE(usb_if->dev))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct peak_usb_device *dev =3D usb_if->dev[ctrl_i=
dx];=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct net_device *netdev =3D dev->netdev;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct can_frame *can_frame;=0A=
@@ -573,6 +577,10 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_p=
ro_interface *usb_if,=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 const u16 raw_status =3D le16_to_cpu(er->status);=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 const unsigned int ctrl_idx =3D (er->channel >> 4)=
 & 0x0f;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if (ctrl_idx >=3D ARRAY_SIZE(usb_if->dev))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct peak_usb_device *dev =3D usb_if->dev[ctrl_i=
dx];=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct net_device *netdev =3D dev->netdev;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct can_frame *can_frame;=0A=
--=0A=
2.53.0=0A=

