Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356AB27652E
	for <lists+linux-can@lfdr.de>; Thu, 24 Sep 2020 02:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIXAfY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 20:35:24 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:23734
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbgIXAfX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 23 Sep 2020 20:35:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMuEuh2oOIYyGAuJEnKevKL1buMExz2OzAui8SmF2FZ1m5bCiENqZSUhyHk3PXBei/3lVVy/8t7by1ClJs6UKJrAa2YYow3NMGZEYbijUC3xL9aXTNtasyWdgGBD8I94tudi9pjkkrVdJ95YAkmYSgJojNDLwOW+fSLpJVK05SusAcYDsM4s0ZdwstyqlYFFgsR2LjtouPnBwbG4SSI8fwyDEw1XerMrDsiuNhE51/nkaHqESB+N7Oanuw9d/4epV5IEPavCx76AG6v8J4gP7oB6QmKA1nuax4scoVAgdUl1e08pLzY3il/T5tzUEt3At4L+x4oK7ENMxzh4SyA0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfvxyWdMvaJMVLpWLBCUyBze8Wxr0zyBs8lviV49uxY=;
 b=hUw7cHkrGuyAzzNJzdhEmUCwmdZ/V/1CgYFk0EiY1JaA2gngRTQ0rKW2Wihq7y5dpPmvlm+pbHPEjchI2AQZbkc5pAKUOF+OYhhC/j8hYY3enXzejQ4pba5Ew/X0OtNt0m9TsspdRmSGFw8txkRxexFeGH2hOT6yDeRr/TF+nGid4mniZpWM7U81Fz896JTXPPgYthg+5KMuo9mfIeSVq6I20CmomIcpqF8iDFAnhY2VIqAzurvU3nszTvxL/4gVOjUtwuDphYpXv50hT5SHhU0duXdXH2gfyjxVIa72Yf1FNrsYT6cLXC/iCuZwq3X+of7/i3zmhyJqQo2zsVNnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfvxyWdMvaJMVLpWLBCUyBze8Wxr0zyBs8lviV49uxY=;
 b=fANMi02OYs4M5Th+WssSCOBYTJnDRv4V/iTY66zlW3Jno2Re0030GuizHNJlICXwCPnT2GsIZX3JNPJb5YZzpUB+gS0z+RBPaPMSJW+s3en2N0m3Od2TbKSIBUOo4Jw8ebF1a+shZxbeZKLaNopCk3PiE/ZveJkQJpFPJa7Ac5I=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VI1PR04MB4061.eurprd04.prod.outlook.com (2603:10a6:803:4d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 00:35:18 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::8db9:c62f:dac5:ee3d]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::8db9:c62f:dac5:ee3d%3]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 00:35:18 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
Thread-Topic: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
Thread-Index: AQHWkY/3EoU1wnrBSEO6n1vlKlAjpql28PzQ
Date:   Thu, 24 Sep 2020 00:35:17 +0000
Message-ID: <VE1PR04MB6687AC23E100D138FEDB012A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200923095711.11355-1-michael@walle.cc>
 <20200923095711.11355-2-michael@walle.cc>
In-Reply-To: <20200923095711.11355-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.234.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4e205d5-aef5-43bc-33d0-08d86021b6ac
x-ms-traffictypediagnostic: VI1PR04MB4061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4061B63486578638BA2ACAF58F390@VI1PR04MB4061.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lr/gh4LUMhYAidPMjucNOWJop56PnnXy9Q9FV2s/+TFFlYNwyNGqF0LWEgdQy8cURpYFHjON3Xqp/hYw7yLQm8koNIIH9cClN+l0SUa2BDQBl/VeSGlKWTbp9F6mfEC2llMn+VOTxabI4J4/1VKdv/4mWJPmCV0If7daRBqMYRt/JjKvKPaY+yFB8XAFrGbUTDC8e1AmSGyz+7f7NGr+HMnzzV/FnfHOGA9mnN2t29/CsmBhUL4bD1fuMmcDUn38XCeeRki5OaQ7835Ma1G7jpbZuj1fn9RJVLZiBlky+7r/KSQJTu0P7xcnqMLjnbYr+0bZFcBA6JqcKpWLhE584MeXwa+YKpbfdmKpMAEnHxqRu7RpYdnIwd5R988rJg90
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(86362001)(110136005)(26005)(71200400001)(33656002)(316002)(8936002)(186003)(83380400001)(55016002)(53546011)(6506007)(9686003)(8676002)(54906003)(4326008)(2906002)(52536014)(76116006)(5660300002)(478600001)(66946007)(7696005)(64756008)(66556008)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pOSTb1bRTzp7oUjn9xLx1oydW6liMqUFutRuliBqcSCLSu05765ZzXZxNJuK7JWFFOl+UMq5JIzc56G+3A3EsvcKQlemij+buPeEEP/WtvGblM1OZ9YKecEsLvYU7Y7uPNWs5ScwfvtHvBBHfHQBOjIf4DX+O1jmAZVU6XoipmUOZwDExdW2LLVOagjxdKDf7DZ3BTOSWi7sMRyC5zdACZzDHqY/MGDm3AAPFsGmZsJsBZo/qTH0t26COfX2YHhRvHf6l/OiCFPDLcqym1K9++3dYjsmD+cDm1nu0jPfGnz5O2eFDdLEjmXGV/Hw5+w2zu+TFWH15YGGtHnrrihuqxFvTdF0KwPahSazA9CRI4eggGRKr1GFDImlbnlNGH2iEl63P08RMjXunf1gjExcf/cKlXoGMJR1jZq4rMYGjyy0rbJ6ZRALO8J+hvLJ2VYfY4K5L+ELQFAXcgK/nKm0s/V0Fy7gwvogC8DZnn34N0ONzblui4MK+GqkFpx35eaEkzwWSTrUCGDGRnSZdtUoAtSczy7SMdjomY/y+czbKwutBNiDZB1XSE5S0lrjmDxLUlD9VPlDKP0L0UaTgbsN5yYGM5aUrq7OKktW4L9tWi0a2Fxlwi5WlcuYuQl+bM4V595tEm9wXYBS+hnvquqmdw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e205d5-aef5-43bc-33d0-08d86021b6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 00:35:18.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjMRSILYLvNVIAVm00phrl4aJZSdd7npI6cYfc7P1742ROlOKV0Eg0muUpB8aXmgELIvAyzDsgrI2k4JrSwbOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4061
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Wednesday, September 23, 2020 4:57 AM
> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; linux-can@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Marc Kleine-Budde <mkl@pengutronix.de>;
> Joakim Zhang <qiangqing.zhang@nxp.com>; Michael Walle
> <michael@walle.cc>
> Subject: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
>=20
> The LS1028A has two FlexCAN controller. These are compatible with the one=
s
> from the LX2160A. Add the nodes.
>=20
> The first controller was tested on the Kontron sl28 board.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 0efeb8fa773e..807ee921ec12 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -386,6 +386,24 @@
>  			status =3D "disabled";
>  		};
>=20
> +		can0: can@2180000 {
> +			compatible =3D "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-
> flexcan";

The explicit compatible strings cannot be found in the binding, but matched=
 by the "fsl,<processor>-flexcan" pattern in the binding.  Is this consider=
ed to be acceptable now?

> +			reg =3D <0x0 0x2180000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&sysclk>, <&clockgen 4 1>;
> +			clock-names =3D "ipg", "per";
> +			status =3D "disabled";
> +		};
> +
> +		can1: can@2190000 {
> +			compatible =3D "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-
> flexcan";
> +			reg =3D <0x0 0x2190000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&sysclk>, <&clockgen 4 1>;
> +			clock-names =3D "ipg", "per";
> +			status =3D "disabled";
> +		};
> +
>  		duart0: serial@21c0500 {
>  			compatible =3D "fsl,ns16550", "ns16550a";
>  			reg =3D <0x00 0x21c0500 0x0 0x100>;
> --
> 2.20.1

