Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7026DC45
	for <lists+linux-can@lfdr.de>; Thu, 17 Sep 2020 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIQM7d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Sep 2020 08:59:33 -0400
Received: from mail-am6eur05on2062.outbound.protection.outlook.com ([40.107.22.62]:5057
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727032AbgIQM7a (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 17 Sep 2020 08:59:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grWuwHOJxuQw3YlFE6okquI8yoBsyZCD+GHg//BfgBNv+blp76Yn9QPWU48wu4SF+HeQiQKp/mwfBAiDMmqZq9vWkvCrY+oM7oisOwsM018D+JS8Ttcwt+lxEwcowehQRevtSbLuabJhggorElrk6T4Fpp8V66akj9VNq+hP8eiLusindxBh7KGM2+dTWGNL+w70UBqrZyW/sOCRVRYS8hITBbk2Xak3e1T3ajNGMAXnjgNS1e80GcjtWZ68fH9f0rSJ45T+kL07Q2s3/gELMK3u6er0aBmue0Dap6eJNsiWHUvZzZ5g2mifvSDU7RrUKrL3+IZVRHw/nmikEXyEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa1n1Vf18ISZsStUqmVK4Liniy4FcCmkeLjQad/Cd+Y=;
 b=IBWwZ/zxz+pkHQ7NO/F94Xqv5ktpGYT5F2uB4aB6ECKSQyMndPMQ/a3WaEUmd+RKjJP+p7dCh/YFhtY9OLsuLkAFyBuLdy4+MTok3gGM/h26jiWT1ivxCS7ktjET2zfZ02IEhvDyrWIFCfQ/1MxLKmNykEtp87Uh2VgfTuWjcGl5eN3WYM+mZlhEAZnrCXa/uUh0KBzvq8vQUAPqGPjzsI8YrTYT7yPNNfTLIYZrP0BKCR3jyqb/fM3Wv0SVq8ConTuijVvU4nXoNCl2Dq/OmNNNrepvpm8OicQmDloI096lXp5372OuxFA6IJHMGFe+07h2ukknFqgSuUpt10ubdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa1n1Vf18ISZsStUqmVK4Liniy4FcCmkeLjQad/Cd+Y=;
 b=BVpuRC46eGyYYappTigOs9POkTFuw3VslfgUwkkl2leuws2avajxgvd9yNPYfpYDuFeo0bPBQEuQilwimwHLPghgHjmSTtc0zF6zRl0nQvJDlqHcUsnGofd9FdnnHvvKsCJ8ZbpC0Ns/OFgxkezsGDP+mIRXk6ehnlm/eYLrlhc=
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VE1PR04MB6639.eurprd04.prod.outlook.com (2603:10a6:803:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 12:59:15 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::983b:73a7:cc93:e63d]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::983b:73a7:cc93:e63d%3]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 12:59:15 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Pankaj Bansal (OSS)" <pankaj.bansal@oss.nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: canfdtest on flexcan loopback
Thread-Topic: canfdtest on flexcan loopback
Thread-Index: AQHWjPJYPp8paa7+MUaE9jLcMhtDOg==
Date:   Thu, 17 Sep 2020 12:59:14 +0000
Message-ID: <20200917125913.leisscxw2rrbuzyw@skbuf>
References: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
 <20200916110154.hp4up6yhyokduvf2@skbuf>
 <20200916110448.dsla6vjzy4fvdr22@skbuf>
 <12688d2b-a198-ef5e-dd8f-64957df36574@pengutronix.de>
 <20200916114533.3hlthhfd7xmpamoa@skbuf>
 <77d5c83d-1fb2-0d8a-f1ed-bec4857796e7@pengutronix.de>
 <20200916121437.lfk5vd22qfe3pyjg@skbuf>
In-Reply-To: <20200916121437.lfk5vd22qfe3pyjg@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.217.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8efdce24-4651-46a7-edf2-08d85b097b35
x-ms-traffictypediagnostic: VE1PR04MB6639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6639D6D7F51173C4B96D5A93E03E0@VE1PR04MB6639.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/YM8vMRQmMaVsmlOo96rG52TLvirJF8zVwwqCKWYxAg7VriqSpQi7wDx0ld5zBMst9yakc2ciSiZrvvQri2OrePU8NPGk/rbwl857e7ZV7pnSyDa4MdPrXgdEm68d5Jo7bwBTKpNqOFjtQ1CuYp6b4uwNfxDU18+kPCncYsU71dKBPDkSJqGQk/m/sIBC+tMme+M34I//kU887Ed/yFpjJn0kcg07g7FEo27O+Ibcp3o6Qrbud7MjHBuiXSOIgC6HPbz9hJeVkxtGeJC03qRBHQoOGQV2KPVMVsDPIjwMwmDQZZY3+SBrc/50ONjXPo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(66946007)(478600001)(66556008)(316002)(66476007)(86362001)(6506007)(54906003)(91956017)(76116006)(64756008)(33716001)(83380400001)(66446008)(6916009)(8676002)(8936002)(4744005)(2906002)(3480700007)(71200400001)(1076003)(6486002)(6512007)(9686003)(44832011)(26005)(186003)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1fn9bAcpCTCq75VuFJiir8fIXudcF1hu0u4F9DbMGEe2hCmTPoSk35cXpkt0jt+veQn12S8d4teMC9z633g9yYKKnQbSSHDbl6Os2P2/6oOL5QaSS7TMwoJshDhIN8elwORcLOq6yIg5svDY8pyY0srXUfzn9l8LCksFX5pxxoke7U/tF741+WgZnukE1sFLot97wHbwV95M0nv4NoZad6rNP9J3V9p2LP61XT7DLarszbdfcgzo1wMlCPrr4ONPcZBb9N2RId6CeSyG6UYl1lkTfvtg5IyJGQuKPZBk4NiihC62R89gVzDT2789RLKEsAPGGD+tlvFeUqHE9G+JiOR2MpNwa7VzR8akT8ROuFpbHbBoGh8Fd2OIXA6OafAdWFgZkkQLYXn6ujpi2bttamPvbb4Vtgpyii30zDiUkWIu3QUTx3hDZzq70bBkt0KRoxW20d16kPSbTDhuk4taQjypIrqKy24Ot3PO9Kn/QW0tAuJQAW2Db99HpWzlGvWU9OA/xRBiES5w6yscsY9WCaTMux5/3Gl1Qrl54HgV708dX34lTd7zVFLGDr9u9wZMe+vjwBhE8CJ/exQ3SJQcJz8cRpAj6Ro9bBQDIbjvbYADWNL8dC2O45GAnp9NixG1Lz5D6OR+dpZ+gHxMHW+khA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <296E75679E48F54AB8083557E1824F1A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efdce24-4651-46a7-edf2-08d85b097b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 12:59:15.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: plRv2We4e2Y0sGN7p7eq3MNXOMnHpzUAyYDsHObP68dNEI0Rfy3LPzCeBDHN09WQbgbk7HDulNeilZDt8/VokQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6639
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Sep 16, 2020 at 03:14:37PM +0300, Vladimir Oltean wrote:
> Nonetheless, you bring up a good point. I'll try to bring into net-next
> the minimum amount of required delta (which seems to be the
> fsl_lx2160a_r1_devtype_data structure only), and I'll re-test.

So I'm back with some interesting results.

Test 1:
NXP LSDK 20.04 based on v5.4.3 - reordering reproduces instantly

Test 2:
net-next 5.9-rc3 with upstream defconfig and all downstream patches
imported from LSDK - hasn't reproduced in 20 hours of testing

Test 3:
net-next 5.9-rc3 with .config imported from LSDK - hasn't reproduced in
335 iterations

Test 4:
linux stable linux-5.4.y - hasn't reproduced in 137 iterations

Test 5:
torvalds v5.4.3 - reproduces instantly

Thanks,
-Vladimir=
