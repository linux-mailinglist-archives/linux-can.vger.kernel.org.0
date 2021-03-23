Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2053456CA
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 05:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWEcT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 00:32:19 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:1605
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229451AbhCWEbu (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 23 Mar 2021 00:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF6FD34fRf3LriZSVlz03mxjOcNQebeNJg+aJhF8MvPaBtssEapHilkeetycwFAgngbflSfKOGYZnJ/mN3PkoaFPLUFxMNl3HueChhAOGkxXQds6wNSzYjizLM50czRLsAMhMrAWsPnvIB5ph/E+OtcwTq39lo2QLmkRsBTk6yRqSATsuwypwLk1c3qnVYvIjlNB0yX05PKaS7DfVl94zOXwDeZJ+lmLWAZlWa1fEBdaAMwAW0B0TbDbwxveBnDSIpvDIw93EKbB1Nx1O7wItrVmGvErPxGjzY7KI4HpgIm8aoO/Xn5qy0w6XRShF/LfRarFantlcwe4XlMSzGeS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbp5qY1CsHWHJg5CYlSsEiEdkGawYCu3cZgSSiCJ/7g=;
 b=hfmeDzCDSiYlEPsHnPsNnXrD2NHJQGVlXAIjuCdm8pGV/S8VJfAsRw1oOZIHcPsnilpuG8KC/rZ7CDNpTG6cNI6sdawoj/IUae5cCsKoaTNRgi5KIjXTW3PJqCYJHSlX+LO9eQx/WTLEhgOiP28RJP0hSaqnNbjPlz7TYHwHiPM9rlc7fJWkl9qefexkN24WqKbmNpsK4+9Zmfjgi1S1NloWVpoGFuLc69FAUIJ76AJokSI2AvnNtvRlizawuGO6BrGwbEp8hv5XrZS8ztCI6Z8W7hedABrTa7Cll5HCMAF0+EzvEcdTBhk4tNkPYxNMEjrP5g8k1ZX9rLZ8RfQjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbp5qY1CsHWHJg5CYlSsEiEdkGawYCu3cZgSSiCJ/7g=;
 b=ad9pstX0M36HJBzipffDbBY4Ty4E8h8Ro8l+Vum0DeWzgMqMPi3iQ82tewJIfspOJ3/FPxntPNVRcq2BNQB+JpFzCJ3o8NX0NapiGHliSQFGSjcyLvvmS3q/Ar9wSPhm42tvhoSlK194xkVXpkVUfue29YUE1GpAV3O0Ed6UR/I=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 04:31:48 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9598:ace0:4417:d1d5]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9598:ace0:4417:d1d5%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 04:31:41 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Han Xu <han.xu@nxp.com>
Subject: CAN performance test
Thread-Topic: CAN performance test
Thread-Index: AdcfnJoGB+57WM0vSGmlPUSs8pFyIg==
Date:   Tue, 23 Mar 2021 04:31:41 +0000
Message-ID: <DB8PR04MB6795C0366E4B43B3D12461EDE6649@DB8PR04MB6795.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e4308d7-6881-40dd-e515-08d8edb48ed9
x-ms-traffictypediagnostic: DBBPR04MB7628:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB7628F78F07E08FE183D7F737E6649@DBBPR04MB7628.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmQeTmFrdwsNJfctCvj07b6MR2jQ1+1Dk+jtMcF2nBheiv7JKBimgt2VNtElygBaSw+2oaxWmBOTRzb/FXTReZ2jANSjfgXIfyxA+DnTcqrZzaFsJMdY+UA1kYyESqarjRYV1nMCoKzO2ALujPZWQ4xQRlfTf2N4KDra4SLjWTAr7dQTUWzEoV1o4b5Flp72XEY0jF9ekq5etTf4p/+c+fVxBqPkduR//1RIlpZ+eJHBmzDEeq9yTg64eJbqXQPtStpxHiv7ilaSqx8pluZeBKj29TsH3l1mDgNrC6EkPlkdXa9TwaEnIaLW74+ZR2lixPCzqw3X4Yk5nIf+icuboWMLb6MarN7K6xU5+ghQp3YmlQNWceyQ2Oa3xCPEZm8vkdFQ8yVHWkNIa2Q+LQQrbyzNaQF/iyFxKfyzeyuqTbULNxI4uKN1xgGp6ypsLQQF0Tc5p5rKT9HbMj8Bv/rVPS5aAK6ASOToQOpiXvRusbGcaWdABvRKiIUMsjvo5Qlj2Ssmru4WQzPYcc1s/kPZC+hJlhoM60enQR+obsDSAu8C0EelIjXJwX0Z86dGjPs3hpViE1x9/TJUHi4hgniaE3lW8Gp8pB4jkrXBr6q6yulnz9br9Y5h+Mqt8iZDdiO2pjer5fjGktHDzLTNUsXqVwrTlvaDjV9D4X8dZZTng1g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(64756008)(316002)(66556008)(478600001)(76116006)(86362001)(6506007)(66946007)(55016002)(66476007)(7696005)(9686003)(4326008)(8676002)(52536014)(110136005)(33656002)(7116003)(66446008)(38100700001)(8936002)(186003)(5660300002)(558084003)(71200400001)(2906002)(26005)(3480700007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZnxqKrpf9oFZWcxBDhNiqy6CyHUJAwoxl1HPKl/0bnsdB2KkFQUCQGYDEdd0?=
 =?us-ascii?Q?SZEFKVU06O0m9XhqtxOjApxIVb1ArVoN1z4f7UVov5hmdQ7cg+WSq6rXV+vo?=
 =?us-ascii?Q?jaORI3+CYU9IsufmNbayuaEGJ2ULV2kne8qXgl8Bnjjz8d1my89RCOdbLUB+?=
 =?us-ascii?Q?zgUSFjpwI9U8y225cYEGsJB2+uu+muK2NXZ0SdNs9w2BSTNjQfrUcpwGuYCQ?=
 =?us-ascii?Q?QYqi/7ulvd8tegGmiRl79+uA51LXwID0nZ4uemn0jAnjoi6SzTwXz9hy1GZt?=
 =?us-ascii?Q?x/YUoq5fWx7hu2qrp6ORB8Rj7wRyu6/t0cqObYPWw+cPWdg0mu2JaqsOAnQy?=
 =?us-ascii?Q?G7DhMAf/0SdOQl3M/XdFKCQdnbOrT4pFQwakTpSqwz1Oy41T4jYwx3CbZVrR?=
 =?us-ascii?Q?nK2ZfrtImpqbrAMdZsjG8SmoGatWsB6pXC7uzo0CYwOLzjC/sEE9iSh8GrkH?=
 =?us-ascii?Q?ZXA07KmE+RqZnbGKkpdcWXzxg31oRf3v6hBPQUt5DJaeCPupMHUvONlJHrrx?=
 =?us-ascii?Q?aDDrKdFnkz/9a/4N1by1IP/UYaCT3h3ImQyeMc1pQ3KfXPUvc3yN9d58klvX?=
 =?us-ascii?Q?n5BaHOmi54+NzZlnFoHivmMoEjNjmR4wLkjFklQAER/+HUux44/v8AT5J2XM?=
 =?us-ascii?Q?RxnEz6uhPlt2zgHtX+0rCPA8ccxqicjDV3aF6LOxmN2GhM08wJvwO165iNMj?=
 =?us-ascii?Q?MVzYEko+Pv04SOUJYxgG52LcUBCEo87+wVSA/xWI99DqnLYgB/aKHJJSta0/?=
 =?us-ascii?Q?NA20lcVdY2fvQA9Zd9to7Gb8cs+JwnSCNYzH8n+VVhzamIcxzE9ATqBsyez+?=
 =?us-ascii?Q?tkk/xroMkFse0xn4Fokbv/nTchNJZqhRp9MWv7qBg5T6S89s1zargLy3HYK6?=
 =?us-ascii?Q?DfdFHd6IaHJ+/IQW7L3DSlTsNPHS3iAHGbFMHKH0M1TK00QtJ5n5xBSWI7e7?=
 =?us-ascii?Q?EI2dxytU/6Mmieylk4Glw7QtSLW+rxwpSttOdUoDU1XiBJ9vyIgYriljMsHH?=
 =?us-ascii?Q?bnlwF6g16oHdybdl7u1W+dka+E4uLfetnoxpjQ/T3/VFF5NV1pBdNMhvsDSF?=
 =?us-ascii?Q?fQpqdgps61v7FPkp7qvQyZX12GUk26x7ufVFRefXtkVrkjZ8Ax6B5lsb2CzL?=
 =?us-ascii?Q?w7zQQuab9xoD5ZjtRvFnfFUkc7ccuPSS8OMf77KIac4GdrSY9qpc73NCztCC?=
 =?us-ascii?Q?vBQsfuEs6AxorQmVgCU2cY1SL8X4k5PUTbCS4F+p306wdkRbPSAygo3Y7So+?=
 =?us-ascii?Q?eZvKYGI5VrgmQRBQyn2hwgdhQziRjLcTyg3IB5aPTRlHfgPLSAVttv69Mh44?=
 =?us-ascii?Q?/LmVtaqzMAYrswTMmXud41a4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4308d7-6881-40dd-e515-08d8edb48ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 04:31:41.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilnm3pXjmX9erUIC3Ufq3gJacRgzbQr0FTScsxRVSKxMCmc0LjsnWq4WxdE9x6sYm+yVTVlIUzAGYIDvHd6LIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Hi Marc,

Do you know there is some easy ways for us to test CAN performance? I teste=
d it before by hardcode the driver, it's not a good way. Thanks a lot!

Best Regards,
Joakim Zhang

