Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5745425A3F4
	for <lists+linux-can@lfdr.de>; Wed,  2 Sep 2020 05:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIBDQz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Sep 2020 23:16:55 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:50498
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbgIBDQw (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 1 Sep 2020 23:16:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr8p67iVFjwsAjW61v/EmY8EXDnxI8EZr1D7Hlm7E/9alFwd8boFVHNHeuuZ7BlcI3wn9HpDxDJvCm7J182sM9bDJBGl0b0dHUEMs7/wYHx6DTUxFEIXDus/ZqP5/scYlv1u2EQqBZ4vlyqHfxqPuOolYHDR9Z1uAiH8ms0EMsU02nSL0iApeBgd5cZHafvNlF+LsHi1VFWNVI0B8EdMeXEm7FmLo4b1dqlE5T7aofn/PgUvZ7e24R7NHL3UxgRB737MzPlKLNnANJpFALppK0iqRQm/FMSxj/jo88cKeU42LAS592u43NLXlTly7oY6ITHPVha/SW+q/Wb6/v+DYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEoXdF3XgUh2347AjTMlHMzkYpYY/KugoCmizwX6bqE=;
 b=cqA5wZrvfmyAeD8EpGXmZhK70XbEtR5BjXbU+TUsDNB4qVGnTm/SVTWEoF5sn4FIQAeCrk9QZEHiVqUZClAly03aASJjwqOLBQke5b9FehVxMsmLdguOaEiPq2Q+GzdSsK+yhmbeXjArbDC4yG8DfxdczLVIhMYTOnG2qDDhegCC30zsvHrlploTvvKkrOB7JCYv+z/CsGekpCI/v4R+D3oI5bpL3GAz2LImpQwCYdTrHX8dhmhe+vrOLBTolt/Ejkoio2YKjZi3yZsIHNdJ+utrh24mvl4Z2rbEfNGbKfhtKoolc20mIuZCVEILymoH5Uu41L9KIkSc0mJ6ilLhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEoXdF3XgUh2347AjTMlHMzkYpYY/KugoCmizwX6bqE=;
 b=aLTqf3lyPKFV7zWT1NEcz099qSGcPWNZqBjSiSqvj0ewgIgfRA3tKrW+19vPhnhmI0RSFqZzTteJBd1mM6BLtZPPp3DuWk0Jjg+zqNeFN6FopxnKeux59/jneIQ3SIKx4K7ZBQQrYLyY10OGucnNPJ2DtFrigwQ3q5WGIYONPOs=
Received: from VI1PR04MB4093.eurprd04.prod.outlook.com (2603:10a6:803:40::33)
 by VI1PR0402MB3728.eurprd04.prod.outlook.com (2603:10a6:803:1f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 03:16:47 +0000
Received: from VI1PR04MB4093.eurprd04.prod.outlook.com
 ([fe80::b0a0:b6c5:a4d5:7bd3]) by VI1PR04MB4093.eurprd04.prod.outlook.com
 ([fe80::b0a0:b6c5:a4d5:7bd3%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 03:16:47 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     "Pankaj Bansal (OSS)" <pankaj.bansal@oss.nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: canfdtest on flexcan loopback
Thread-Topic: canfdtest on flexcan loopback
Thread-Index: AdaA1oPvF2ksseKmSLeb8OzLcaFJ8Q==
Date:   Wed, 2 Sep 2020 03:16:47 +0000
Message-ID: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [49.36.130.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5030fdee-b24f-491b-2959-08d84eeea07b
x-ms-traffictypediagnostic: VI1PR0402MB3728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB37286A5C79EECD284125FD3AF12F0@VI1PR0402MB3728.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LXltzZXRov96RwWxt1QfY5yLWhJmbd5Cov8YoQ7kvaz4PksWf2jCcn/ERMIB5cfuIBiVxtByplqPu7xVzxTB/cKdiXSgy6A2Qlo+MMbU4SeYk64HsOd9E2ZycZL1MlOE+TQ2AirHxrWtXo+D7D982QQUVqc3/xFM5EziEcjjaoZv2Bv9XDinGj6xJ3xo7iFTlIWrZsNJp3vtq8Qwf5OZezIFvVzcE0PWEufxvF+PI5lGeETNP357itIey6oOqxcCDS+4ikwAYIYOnGvOwnDFnzMnWJ1Cf1l/4GpkhcLvT6jcWqFUNNgI7ZOg99Yls+vJ8N16VSCxtp9owWvNb8UNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4093.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(8676002)(4326008)(186003)(26005)(66556008)(64756008)(66446008)(66476007)(7696005)(8936002)(66946007)(86362001)(5660300002)(76116006)(6506007)(2906002)(83380400001)(3480700007)(110136005)(55016002)(71200400001)(54906003)(9686003)(52536014)(44832011)(478600001)(33656002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2QB0EBadUNRxMiMh3Q9fw1TM2kcCm08p2h+EFOt5cHN5/59g1vIKGO3WKgQ8GKWF0EiHV8Gxo+j53FZKvAgT+SPQ6fLnQovzo1HawdAmVCqUgKexbm4Xz+sgtEAM6VNBpBsoPP2sn/enjaABs1/B3FfDN7B4aqrSgCdTUPd5iRH4W1RK4HRrlvmVM1yyfSWdKfc3DW4AqAjRkce+hMu8f7faPGuRrI6gIiIj/p5nlbNL1etvV6m1OXNx/v0waVrwVhPBz5lxjaZ1l2NJosGZcwkgmRhjlhYdeKm6oFwMinpwsIikt67I39Q5n9++Jj5HdgURgmOcu93Km5NqSgUhPagKZ4n30/KJpVcJTutOsohLXrAB8kkb4VXRepMZzf1eAGFj5iLhKs/t4fBBxQBPW6vVGlDpNCvLD5pPJOUYtBSexy5zOmrWFr4XVAIVMI/6qf2sr0uR2aY2WcaCg3DxZCzRK9+H7BxdL2cbzfS0GWFO/wuzWgdhtM2orDRYmeHvnPenlsMr6pSXbC4WqNdjgeNhJTcVcldRYzl4rv3eMnd7gCdC5bLmQ+HdS0Z5ncRdKkrdgDlguy2abl1tP1qoNsrTioTsLpz15X/WiqdQUCMGmwpoE/DIeEw8vJw7bd9nnmg5+4oZKU0XTx+ZnR9oTA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4093.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5030fdee-b24f-491b-2959-08d84eeea07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 03:16:47.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2NAFTAcrFufahsT5GyCfTY/xfP2mFnoDZ7lToItM6/FLfoW1Q2dQXqNPnCRmr9Wo9ltpe7DNeWKnxRsG07XnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3728
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc et al,

I am running the canfdtest (can-utils-2020.02.04) on flexcan interface runn=
ing in loopback mode:

# ip link set can1 up type can bitrate 125000 loopback on
# canfdtest -v -g can1
interface =3D can1, family =3D 29, type =3D 3, proto =3D 1
Databyte 0 mismatch !
expected: 0077: [8] 01 02 03 04 05 06 07 08
received: 0077: [8] 00 01 02 03 04 05 06 07
Databyte 1 mismatch !
expected: 0077: [8] 01 02 03 04 05 06 07 08
received: 0077: [8] 00 01 02 03 04 05 06 07
Databyte 2 mismatch !
expected: 0077: [8] 01 02 03 04 05 06 07 08
received: 0077: [8] 00 01 02 03 04 05 06 07
Databyte 3 mismatch !
expected: 0077: [8] 01 02 03 04 05 06 07 08
received: 0077: [8] 00 01 02 03 04 05 06 07
Databyte 4 mismatch !
expected: 0077: [8] 01 02 03 04 05 06 07 08
received: 0077: [8] 00 01 02 03 04 05 06 07
Databyte 5 mismatch !
expected: 0077: [8] 01 02 03 04 05 06 07 08
received: 0077: [8] 00 01 02 03 04 05 06 07
Databyte 6 mismatch !
expected: 0077: [8] 01 02 03 04 05 06 07 08
received: 0077: [8] 00 01 02 03 04 05 06 07
Databyte 7 mismatch !
expected: 0077: [8] 01 02 03 04 05 06 07 08
received: 0077: [8] 00 01 02 03 04 05 06 07

Test messages sent and received: 0
Exiting...

However when I run cangen, then the order of frames is fine:

# candump can1 &
# cangen -n 100 can1
  can1  4B2   [6]  65 BD 28 6D 49 0A
  can1  4B2   [6]  65 BD 28 6D 49 0A
  can1  7FF   [8]  8D 05 E2 50 B0 C0 8D 79
  can1  7FF   [8]  8D 05 E2 50 B0 C0 8D 79
  can1  397   [0]
  can1  397   [0]
  can1  3A2   [0]
  can1  3A2   [0]
  can1  143   [8]  22 A1 C5 56 FF 24 15 3A
  can1  143   [8]  22 A1 C5 56 FF 24 15 3A
  can1  036   [8]  6D 5B 6C 6D E8 39 E6 5E
  can1  036   [8]  6D 5B 6C 6D E8 39 E6 5E
  can1  393   [0]
  can1  393   [0]
  can1  5FC   [6]  42 CC F2 57 AE 22
  can1  5FC   [6]  42 CC F2 57 AE 22
  can1  08C   [7]  F8 2C BD 6F 8B 98 53
  can1  08C   [7]  F8 2C BD 6F 8B 98 53
  can1  4E1   [5]  3C 59 E1 3D 78
  can1  4E1   [5]  3C 59 E1 3D 78
  can1  6D6   [6]  5D AF EF 06 78 EA
  can1  6D6   [6]  5D AF EF 06 78 EA
  can1  217   [7]  10 DB EC 26 5A F3 49
  can1  217   [7]  10 DB EC 26 5A F3 49
  can1  072   [2]  59 18
  can1  072   [2]  59 18
  can1  5BF   [7]  91 BA 17 7F 52 F1 0D
  can1  5BF   [7]  91 BA 17 7F 52 F1 0D
  can1  307   [2]  C9 DA
  can1  307   [2]  C9 DA
  can1  628   [8]  B2 9B 31 26 B4 46 10 30
  can1  628   [8]  B2 9B 31 26 B4 46 10 30
  can1  0B2   [8]  3F DF 63 74 94 6D 33 4B
  can1  0B2   [8]  3F DF 63 74 94 6D 33 4B
  can1  330   [8]  0C BE 31 4B 06 FA 5C 78
  can1  330   [8]  0C BE 31 4B 06 FA 5C 78
  can1  142   [8]  7E E4 3E 69 59 7B 28 64
  can1  142   [8]  7E E4 3E 69 59 7B 28 64
  can1  511   [8]  B3 6E 72 1F 83 6D FF 3A
  can1  511   [8]  B3 6E 72 1F 83 6D FF 3A
  can1  3C1   [8]  2C EE 30 5B 80 79 51 13
  can1  3C1   [8]  2C EE 30 5B 80 79 51 13
  can1  2D4   [8]  D2 6A 5F 00 DB ED D4 38
  can1  2D4   [8]  D2 6A 5F 00 DB ED D4 38
  can1  3F0   [8]  DF 66 77 38 18 A2 1D 4D
  can1  3F0   [8]  DF 66 77 38 18 A2 1D 4D

I am using the latest Linux-stable-rc kernel (v5.9-rc2).

Is this known issue/limitation with canfdtest application ?

Regards,
Pankaj Bansal
