Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5574E5321
	for <lists+linux-can@lfdr.de>; Wed, 23 Mar 2022 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbiCWNaA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Mar 2022 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiCWN36 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Mar 2022 09:29:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55E4B411
        for <linux-can@vger.kernel.org>; Wed, 23 Mar 2022 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648042105; x=1679578105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=01xcpN05wBL5LdIWcxMNzVKuUFj+3p5ZhOSEd9Xusxw=;
  b=X9iFgy2XM3n0QP71Kxx4PQhfVKklDseiRoTDYcUhNm9/J8GdBhxsirU7
   jNSAo/XtKZCJveG1PGclfW6H1XlPfqcEFNLT1ve2VaRtzOWIhEX9d/elx
   vneg+GYkFmQd1BH0dR2y8iZ3NX8FN+qn8rZOuj/X8ZAPr0cFiGF9q8BXy
   3KW25TnIBzPCwAwV7z9jzrwC/Hw2RA6NUpmvFC8mYc54SgfHMzY7BJN9T
   No8vZsvkmdfRjMXHqpJz8re143dqSMkuj8jzOz5WKUjUPnCGKIDNgOuO/
   TExMoA/8gJwXfMIOpO4KBo+KmIwl2Aq1ioHkAiL+y4cG4iiTsFmv5FS/R
   A==;
X-IronPort-AV: E=Sophos;i="5.90,204,1643698800"; 
   d="scan'208";a="157886468"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2022 06:28:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 23 Mar 2022 06:28:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 23 Mar 2022 06:28:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pliq1aUWV49Yf0lF7oIudGB/25UtV5nor7c+qlrP5V5vrqW9bBFBqpT0K60Gemhpycy9Jy/rO3MbjAhQ54gxr5W9oZF6282Lma0EUXju7G2WXO/f40RBOHWcih3PUEM2Ni8AlkKkWsQIZsZSt8dabObpPMhbwBFvl3jCj/Gc408SGhcvag2u8e09l5/zJy4Q+BBMjbIEIBoOgFRgkTxmCmY1LlaRoEP4q1McO7KFW+j9YtwMNvNPVtqHYlPk3p/5T9IeLTS9joXG/8NaI01uZWD7Jo+QQDnm9d/JMMng7SrWzgOS+KFdQiGNzz60wjzsvX0TS/aGjwYU434Nly3TiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF7lfkUdHbNrPR05v+jQM+CSJOX6jhHlSObkcwG6XOc=;
 b=XVZLBcSiIQ37bYc6l574hjFw+DdXYRR+fnZ4TONkcc7+bg37jgHF/QBeYvjZPonoAHHWjouIFo1uJpwKfLO1MnSHAtm//GNRg8Yv/5H+7/NqbJB8FZ8TMF12HTPskhVJ6FcshZtjJZo1foO0jkitVMte8M31Q3brcwEOTVqiTloBLcrDBpqGuIBM/1a6VGTH/b1UurNr45+lt4kpGpgtw463TI48I43r15le9mWFJ8tUkwuqqygB3jjKJtCWHqejcvgTSJ2Kfex6cqy+X6Gi1VVe2jNu875LUCiow52idOfmrV7mdRqsXa0+QiYahQzGmkKGQPToOUjQflGOLAfS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF7lfkUdHbNrPR05v+jQM+CSJOX6jhHlSObkcwG6XOc=;
 b=J6reR8qP5ZBk1DsYNSPS6IiCrtTq54emG1wVZxMqu8L3Cs/QaUj/RgTqE6QS2MHYiyKd7WOR0goMhijqVczlWRpjPemma7nmzOjUtCiV0s3ZqCenhW1cuJhnKVx5GLOgd4BMjU0Co0Vmu1cNXHQ5FCYIiPBqGkoWZV3kCJxcYGU=
Received: from DM4PR11MB5390.namprd11.prod.outlook.com (2603:10b6:5:395::13)
 by BN6PR11MB1827.namprd11.prod.outlook.com (2603:10b6:404:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 13:28:20 +0000
Received: from DM4PR11MB5390.namprd11.prod.outlook.com
 ([fe80::815f:c1cc:e819:cda6]) by DM4PR11MB5390.namprd11.prod.outlook.com
 ([fe80::815f:c1cc:e819:cda6%9]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 13:28:20 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <kernel@pengutronix.de>, <manivannan.sadhasivam@linaro.org>
Subject: RE: can-next 2022-03-13: mcp251xfd: add 
Thread-Topic: can-next 2022-03-13: mcp251xfd: add 
Thread-Index: AQHYNrV85eXBoW8fO0uqUGXLZ/3mU6zNAK7w
Date:   Wed, 23 Mar 2022 13:28:20 +0000
Message-ID: <DM4PR11MB539016D37DC0A025799B809BFB189@DM4PR11MB5390.namprd11.prod.outlook.com>
References: <20220313083640.501791-1-mkl@pengutronix.de>
In-Reply-To: <20220313083640.501791-1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65e7bcb3-27af-4da1-eba5-08da0cd0ff3b
x-ms-traffictypediagnostic: BN6PR11MB1827:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1827825EA4D065AA1A4F7820FB189@BN6PR11MB1827.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzpSJdag0ttapbRao2pSJbvaf7bN++H8Q53Mf6twQa3e9xm1KZuCED0z19NaAgPXi+pCZKw/axCjqcUNLICLtFhrk4b9ccO3oTjuhWeYdFufrI5Ywl7mqT6Qhl8iN1/sgD9Z6UIM3LaNxEIeY5sSUiywBxvBvmZK7Ev1ijTsWGGWohaWlCNOh0gNTHY/+mJZxs1I/V++bIMoTiMqfPnQmzBrTv612bAEz5rd9Zxblb/VCh297udxyoiEQUoh7C38PC9jRYnwHyNlbjLufpm2HuFPCxVIF6blw9JYdW1TAw1anEk+JjX1BnemRD14ggjHMmN6oK5e761vCpMZvxjSiJZascc8q4nmfma5HBVni34/t5XaM1T2IXSjIfdurkKVkrALpT3cFETv/IN8QmKX0VyoQEqCcIbQ/HnV8lUmUFtp/wn3M0Okso2b9fEsgeQ60uGzEjZ398LH5WvCWnwXB/+5bQCW6dQyM3LnEwLsK3mX1zp4EEudTCEpUQ1o4INqxVoTN3GlO+kUdZ+DIuJ7UWQjFubqCEr69MKPXGBU51JmKnOZKfSmWqeq+Fwz1XfDMTaagMsY8RbcBRyAoVRXKUhvsdBnp+XeeOL4ktK+hqZBoU2phvuLEaWVTa0mTizwRj0nt63DXGsW2Ak2kySMmqGbLXr8czunuhglWu7/hcOthIK5dV091fdMehVaH9q4YcmjJ+dT1c9Dvu9GA7DROg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5390.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(316002)(26005)(186003)(86362001)(110136005)(54906003)(66946007)(66476007)(76116006)(66556008)(5660300002)(4326008)(66446008)(52536014)(64756008)(4744005)(8936002)(38100700002)(38070700005)(8676002)(122000001)(2906002)(508600001)(9686003)(33656002)(4743002)(71200400001)(55016003)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q/DKBs74vSA0ahVuiwuCYH/Ndw2saNqcum0GUTE7Mxfx+hAkdUhgNXur3sbH?=
 =?us-ascii?Q?X4qUE4NPd9SrH4H8MtgE080k1X5rY1rGdb5YJwrWpwd22rQ4bnEvbQe0Rr8x?=
 =?us-ascii?Q?a9hv2DOxB+oS5CbZlbE14bX9srDR2mtFBepcFI9tb9NxNA7EjsVCgrSvh88M?=
 =?us-ascii?Q?VdWWoOTP8zdOYvV0RcuHQ8UgbRaQHY9dbv0Gac5kFM8fBxBR6HA+VuR7wqp5?=
 =?us-ascii?Q?cK+t3PQdT/wPr6MCgVApNROJj2CU9kIFy++PamP6pErsUxZk+qwpZjR0ivu9?=
 =?us-ascii?Q?79XHqNmb0N7otfIgwcH/yVrX9evjnozo+z2ceP5KOMd60RrOIr/XytuTTJ++?=
 =?us-ascii?Q?iiU4p8k9Z0oL7AXyqYJFtSjJ9e28zYa1poTe/9BAR+MxQm7AQ578G8iF3vn0?=
 =?us-ascii?Q?YixDjVe+80/A9qzzoehttoV70gZt2MetJwwM9p0xQf1Wp7ytMWtEsmoU6j96?=
 =?us-ascii?Q?0PKw2qyc/PuC0TH/SwsW+MWPqRU7Rl1tpqK1rCeS42FavofJQa599qI8G+v6?=
 =?us-ascii?Q?VR2tPx/Aa50fCLofazdkuPuTfT1IejdGQc4hn1+VqA5YQ4q+Hw+J0mbAFGhm?=
 =?us-ascii?Q?QWW7nj9orjHgH5yghAXOOET8y1A5eD3ri/KBOIDd9Kuxq3VlKOign+HZrnn0?=
 =?us-ascii?Q?16rOpPwHsgYYcQzCbDbwRq0EhlHbPq+V1Qvt1f6nQ+Z4f1XuyZq2iqPGVz9Y?=
 =?us-ascii?Q?gtRORbbirAVJrzBx4tmEoFHoAr5sg4vk6l//6YEP/DcKt1JxgfQZMcDwYAXf?=
 =?us-ascii?Q?A3vHgX17SrjAcfS5RpQiuDU1ch+lOACyV5xP1QW+NbSPabiiDtunEPGH1nUN?=
 =?us-ascii?Q?ZGnAXq36cUm87mjVRUAPaHV1jBwDl2gmLTVzebRNA5zV6lzLEKCJwqU0U7sg?=
 =?us-ascii?Q?UunPJuJy8Q7D+J+Z4GHAHX9ohFm1IEEQFTPJMrPgAuDKhfROvxQHaeBgswoe?=
 =?us-ascii?Q?VP9+xoDgyAS10HPM0FkP7Ihhy6MZkPhJLeZQpSG+/2nVIP8Va0iA1cfa8wjf?=
 =?us-ascii?Q?PjJ42+B/GrPA+h46GNtM3A6L6IY12MTktM74fbY9PYf67TqCw3T2Bm+RyEc9?=
 =?us-ascii?Q?n0neQO8/MHCBCBdYtCmSBgEdSZ1ucEv6x18AcqCPe5K+nhNN4HHgPAkWj0fM?=
 =?us-ascii?Q?wKLH3/pBebSVQafwTmOM73pwGqliKPelaaJ4nwA/Vd6uTWml1QKkWNm++tiT?=
 =?us-ascii?Q?ReTpW66nguE+KP8DA8603Mr6u78CtHYVxU7d1VORVz18hGoVSkWdoEr9beEl?=
 =?us-ascii?Q?s0Bfyr48awGWFS786rtwsA0gqe4u/+S1RsBnifs3KquzeHW9803bMpb4Zcvu?=
 =?us-ascii?Q?Oh/OSKLHSuJiy3kT8psTz6NKGSQLkOK85PBbpIYUoXOUfr20lmaEgSzI1ET+?=
 =?us-ascii?Q?prGWEbMscA0zE5XXp5wlwlVCQupgiR9tvampZ426Pvy9oMTOaR21Uqkh06jc?=
 =?us-ascii?Q?jhsxZOnBmy2H8l2OnIkP7HGrW4feDUKA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5390.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e7bcb3-27af-4da1-eba5-08da0cd0ff3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 13:28:20.0413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJDVC9ac6f/+Bwsc0oPQGgHbVesEuXxWG+x75LztbHt0Aul9gb2/6uaXYLH6spy7vkC8FW6QMqBijf75PZ2q+sFz07Sf58hlNFBtgW+M+K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1827
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

> this series for the mcp251xfd adds IRQ coalescing support.
>=20

Thanks for these patches, the performance gains with activated coalescing l=
ook awesome!
Testing on a Pi4 mostly 1 channel RX-only Full busload scenarios I see sign=
ificantly reduced CPU utilization. This is both for CAN 2.0 and CAN-FD use-=
cases.

I tested this patch series against 5.17 mainline and I think the performanc=
e when NOT using coalescing regressed slightly ("measured"  via sar -u 1, n=
ot sure if that is a valid benchmark?)
I had both driver versions configured for the same fifo sizes and coalescin=
g turned off. The mainline driver actually generates slighty more SPI inter=
rupts in this scenario (20k CAN 2.0 Frames RXed in CAN-FD mode). Not really=
 sure what causes the higher CPU utilization or if it's even relevant (mayb=
e on smaller systems than a Pi4)

Best Regards,
Thomas



