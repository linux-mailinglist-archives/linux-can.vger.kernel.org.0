Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8032775E3
	for <lists+linux-can@lfdr.de>; Thu, 24 Sep 2020 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgIXPxH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Sep 2020 11:53:07 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:1843
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728285AbgIXPxH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 24 Sep 2020 11:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtdunyCUyBmwSomle75+jISeTziPZhoLTgdTZE74pdU9hvY5qEvj0qGTQXwM4HNYB2hDbELl/gQXecZAOAoi7tOpYlhzoSQKg78HouGWssfeV2h4fPYkHtx2cLCFAHuIuXmdxgTwWcda0Nm/NW7WnCce4JAt8quXT+LilmgioAKGzQMyX7hp1TM0WX3NSMXugmTI/e5+99aek3kRqBJSUP5o6kZwioRCF6xkJbX9hkdTiMsjUueXNPRerTivBYGM+Bf8s0o1I66bb5tyHMYxvjGTTybWOthCXJ/SRrczg4Dr+axXzFCuD5Dvs8Ak7S5lYjtxtcwbKL1Cnr1nqYIzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YmF6D8LpY9VEHR/ky7Y03HrqzTfGnR16O1Cd/deOVU=;
 b=k4vy3fsI/mdnimWv7WOwza5Itfa/eUctpOyXO/JfubMa/xeuVEdxRuJTyPdklJGOlj/5O52AB2MWj9cqqttkDrEgRS2gUr1JAwSgEbxvcOab2FKai6Ruz41N1SxH5lxqHKfi8IK92fg40IK7iHtzTezBKP845LexDpjgtJreG1gbyIdpV22MDiWIG86NHz7s7I/m2SB+fsdkTPD+nQ21/DAeIEEPWwI5fvwjoKo8kXXuxpLFQxsDy3diFWmngxMWXNxFl8Ixx5C9TqBdy0IaBzhWhYVfssAfMzSst7jY674FjWpSyyKQi9K/HrVGPgkXM3UfyLsaJM05Osl1Moi2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YmF6D8LpY9VEHR/ky7Y03HrqzTfGnR16O1Cd/deOVU=;
 b=HLD/BU04CEr9zOh4Cpt8jUxn9AqMzhxUpmljbRXxRgyNseF6YUcsTnt6HIll6RW1rnKkmBNKJ/U2vbW6CsPNy4WR1YW10Nam5J6EJlTWpStZkCG78v4kxfQfxNtrvmQm0ZY5fROhbO4A88tcZzrMNryh+s8O7uEU4o7POUWh6Hw=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VE1PR04MB7405.eurprd04.prod.outlook.com (2603:10a6:800:1a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 24 Sep
 2020 15:53:02 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::8db9:c62f:dac5:ee3d]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::8db9:c62f:dac5:ee3d%3]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 15:53:02 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
Thread-Topic: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
Thread-Index: AQHWkY/3EoU1wnrBSEO6n1vlKlAjpql28PzQgAC4PgCAAEgk4A==
Date:   Thu, 24 Sep 2020 15:53:02 +0000
Message-ID: <VE1PR04MB6687CF32DBCC76B4DFBA070A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200923095711.11355-1-michael@walle.cc>
 <20200923095711.11355-2-michael@walle.cc>
 <VE1PR04MB6687AC23E100D138FEDB012A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e9347e4c2e070ee9e8aa7a8007d89f02@walle.cc>
In-Reply-To: <e9347e4c2e070ee9e8aa7a8007d89f02@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.234.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ceb7ee4-6d18-4ba9-4be4-08d860a1eb33
x-ms-traffictypediagnostic: VE1PR04MB7405:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB74054C7BA297D54CE13C943F8F390@VE1PR04MB7405.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1G0ohn7o23KGyZmJ5aGkv7nytPWfE28pUmRd5SV0y/siW49KApFq9wU7yZmHOoNrfITWqx0PG/YwX+mOY1Jx3KszVELy5aEARzacJXn3AQ6scL2ZQl1TiLEH8tD+494zGgyWOMWsuLNUiNjy4C02pHeKRmrebAJbZuC6f2CPccVVHUIS6Mhlpcub3xPfFdW77Qagt4lxWxHIydzydCzj7ZWuaWXkub/SVEbmHYGHlpEw0rcQ1hq84/SfBajs9Qy01UrfJyR3EUl91dAfbIixJeQrOsXHhWGdZnQ3HPsjqj/z0jdX6RC8BzPwVVMoMsVm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(7696005)(33656002)(4326008)(53546011)(6506007)(86362001)(8936002)(2906002)(83380400001)(52536014)(66946007)(66446008)(66556008)(66476007)(76116006)(64756008)(55016002)(9686003)(71200400001)(8676002)(5660300002)(54906003)(478600001)(6916009)(316002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xCAcI/RYVQH9ipPBAG+o63Jej5ksAdoCt1wPLOWIgYaV41qIZ1GbfHq3YhzKmoRFS22PGcjeWnE2S4jJMHv99Ha583rHO6MxmAdakDIiMGDChui6p4hHC2op2DJjc7yJQKn2KJoVlGN+5Et9c3tqGNnj1O6IZRRz63kI0b5a7QaPEpYUI5L3AbypADpOGo2G9JgafZSrq0EpIbdz1OSo3cKcBCjy8YGdREC1nDrjI4c5wj5nteNhTj237l1agV4xHYpbFS7RMahkRQ18Il3cqguVi9vbWlq2H4gqEHRYhjo1Nk4d9XAeBlQ3Z8L3YTHaR/umOGyT/3kjwd5hKFaGkyHT+xhAzQlYv3icZOOS8o9ujj8sNWxlcyRTAm5kv1mOBuLksnsmvesM2rE1Ct4xHh1vjtriQfRmwphMxNRREiLOxqqhHP4MRbiqwUlwemXZOuYHLKeSw0Ppa4CNnCmGQjUggyZeGyx0j3PObWLntG7oseCCfmya3ropk+vdSXjWXUScC+o/zQeeMBEg234tkZYrv7gdN3Phi5hK4RcomitpFFRiJWJEaHLhlJlqFcJL5fK6GrT28mtrgSgML3m72m5VQBoI8ifhknZPL/WLD3ZbjVCLSW0f60lZ2kBAQMTduqjsHiA6FcuJ7onGr79iiA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceb7ee4-6d18-4ba9-4be4-08d860a1eb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 15:53:02.4524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLb+URH7a0oYljHtSLX8gxrpvFLUwlpCLtbJDsEXyuiXrVjHvwepDpRTHEE8LmUYAVJ4JBcreQh0zDmgltOq9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7405
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Thursday, September 24, 2020 6:31 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; linux-can@vger.kernel.org; Shawn Guo
> <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>; Marc Kleine-
> Budde <mkl@pengutronix.de>; Joakim Zhang <qiangqing.zhang@nxp.com>
> Subject: Re: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
>=20
> Am 2020-09-24 02:35, schrieb Leo Li:
> >> -----Original Message-----
> >> From: Michael Walle <michael@walle.cc>
> >> Sent: Wednesday, September 23, 2020 4:57 AM
> >> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> >> linux-
> >> kernel@vger.kernel.org; linux-can@vger.kernel.org
> >> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>;
> Rob
> >> Herring <robh+dt@kernel.org>; Marc Kleine-Budde
> <mkl@pengutronix.de>;
> >> Joakim Zhang <qiangqing.zhang@nxp.com>; Michael Walle
> >> <michael@walle.cc>
> >> Subject: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
> >>
> >> The LS1028A has two FlexCAN controller. These are compatible with the
> >> ones
> >> from the LX2160A. Add the nodes.
> >>
> >> The first controller was tested on the Kontron sl28 board.
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >> ---
> >>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 18
> >> ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> index 0efeb8fa773e..807ee921ec12 100644
> >> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> @@ -386,6 +386,24 @@
> >>  			status =3D "disabled";
> >>  		};
> >>
> >> +		can0: can@2180000 {
> >> +			compatible =3D "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-
> >> flexcan";
> >
> > The explicit compatible strings cannot be found in the binding, but
> > matched by the "fsl,<processor>-flexcan" pattern in the binding.  Is
> > this considered to be acceptable now?
>=20
> What is the consequence if it is not acceptable? replacing the pattern
> with individual compatible strings?

There is a recommendation in the kernel documentation quoted below:

  7) The wildcard "<chip>" may be used in compatible strings, as in
     the following example:

         - compatible: Must contain '"nvidia,<chip>-pcie",
           "nvidia,tegra20-pcie"' where <chip> is tegra30, tegra132, ...

     As in the above example, the known values of "<chip>" should be
     documented if it is used.

But I am not sure if this is still a hard requirement.  If so, we should li=
st the processors in the binding.

Regards,
Leo
