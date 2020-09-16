Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78B226C192
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgIPKYZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 06:24:25 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:50157 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgIPKVj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 06:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600251699; x=1631787699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q+4nXKVt6q5D6RHWphbskZwhT6jQbAPGXV3PEIwJiXU=;
  b=NKzyOTGov4VwDU+vTv7c2w7TeVX/JAE0dox5bYjRLVs1F/Dhq7G/cAj+
   LiyrDGMaGwgzL1fs3L8XiYmJaMf2f8sCjYAjy9221nyLKtx/jnUIRORuu
   RSCeYaqWazNY9vY0QLE2Hkkh7s6a9myXNu1DWT6kJDmOxjO8WdePdgCiL
   P6sJtr8WudxY+PbpAuAER3DhEozN23B6w6ZikuyJhnZ5XeT5t8eI7qgbd
   9iNn9mf/f+uuYeJgho6BvcVxuDIwQHqXUFM1XYpAgez17BjXNqrfWItPG
   MTaMxheUE6L0dCrfgXH3y5lcgSQGX9OuSx3VeaKq3jwZIgZRl4uU21lH5
   g==;
IronPort-SDR: dbPtXeogZLiQ3fFLgZHG4BxfTPhqtk14J7isN3XsUyX9PQ/wRgeBjf3HYab7fV4+J9f40bCmDd
 RSDGO7dojl+e6bUx4M9b1VZLPV9rWc/j3ykp4KnBjxOJ6Hi4394g4DdFngHc5+1Ft096qdKoRV
 7TlEu2hnUnHEFsKywstZ/j11FY2Ug6GuI6St5RVtPf+P6G2FQsz/vaQ7zoq/Q90TA9NBGZuPuW
 DkbQ48JMS8IcKlxOh+YuEJRGwJ8U/Y3fMUfQPZ6tSXFVPCYuY9LzzPLox0Xf7WGodek7dv2wwT
 V20=
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="91197114"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2020 03:20:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 03:20:36 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 03:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZctimH7JBMVwymaThICf44ukuHdecp9/IXVq2FQTThiWojTZOKwqTpyt1nXp632pXUvRDnjaPgbNkULULGDwOo2apUqMbbpYpuBhn4x5hBck3f7LFXrGUXP/xxBVKui/Qqw0hdEE9mJ/rkl2n1qSd1mPO6J7thJCN9RETH26cXc3NvssS21J7qWl/evjoAN1tJCudLNs9cgv2JqMzfrXmijkFilD77q+nQFmtRxAV1NclBIwQqQwLfjiD2clbEGq1+AZ9xQqY+jg7ZtSj9jmKWMDeSxg0i7qp5ht9hix+V3IXq9zFn3EuvwbHv1Th/jRKLEotabkwTKyPXtAVTMq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+4nXKVt6q5D6RHWphbskZwhT6jQbAPGXV3PEIwJiXU=;
 b=Kpg2cLFLLmg2FghnJzOc3wKL/2cytW7s3iAj6OFtDyFKrGGkVMRJ9UCiq8qcigWd1upP0PHtsuQpwUx7F+nnac6fOXBju0WFbJhGJYRDY4058m8LCxVzAR9rNuQNhiQcoeLbfOj0N3eMrHWUBqenOwd4wxkOTLkEaKhBGkUxaXcmOozJPBl9wTuqhCRuagLWGN4XGTRDgbYcyN5rY4zah9/6n/aP9f8wDHphzSV5phSrg0xelvatD0xHxoEBqP5Y+jrkJJa1RbnGEvBPNKBemHab5KzTPppbjQnONz+i3R0JrQJJCy04zkSw+GmRzbERookICF/xqjUhPkYxIc4aQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+4nXKVt6q5D6RHWphbskZwhT6jQbAPGXV3PEIwJiXU=;
 b=uSJZLkY7fXKVjEd8TJnVXM50MMXuQu8j0MBlf+p62DqugzUr5iQQlAduN5679khTfzMLtLr2BxK8j1oxZor67CcmyRE6T/9ejj3Gk3LApj6E+kaln6zsZYLXFHZfOuz8tmvmNB6xtv0RCqvGVMNaYFYXyIgp22ZhzTTjyFG0Lgc=
Received: from DM6PR11MB4283.namprd11.prod.outlook.com (2603:10b6:5:206::32)
 by DM6PR11MB3066.namprd11.prod.outlook.com (2603:10b6:5:64::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 10:20:52 +0000
Received: from DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::a41c:90fd:7385:c8b5]) by DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::a41c:90fd:7385:c8b5%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 10:20:52 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>
Subject: RE: [PATCH] MAINTAINERS: Add reviewer entry for microchip mcp25xxfd
 SPI-CAN network driver
Thread-Topic: [PATCH] MAINTAINERS: Add reviewer entry for microchip mcp25xxfd
 SPI-CAN network driver
Thread-Index: AQHWjBLJm2ww8TxYPUegwckdRZZbx6lrDfLA
Date:   Wed, 16 Sep 2020 10:20:51 +0000
Message-ID: <DM6PR11MB4283850F9D0A341502F8FA0BFB210@DM6PR11MB4283.namprd11.prod.outlook.com>
References: <20200916101334.1277-1-thomas.kopp@microchip.com>
 <d067727d-0b7d-e147-cc1b-abcbddacd216@pengutronix.de>
In-Reply-To: <d067727d-0b7d-e147-cc1b-abcbddacd216@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44c7470e-4421-4127-17d0-08d85a2a307d
x-ms-traffictypediagnostic: DM6PR11MB3066:
x-microsoft-antispam-prvs: <DM6PR11MB3066576864640DB867C3A644FB210@DM6PR11MB3066.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4XFAkot1HUNvlhX8ZkNjfUKQ7fy3uw4lnc9t/MmSaNA3uC17Is/f1yGptHSh82YNV0G+7bbaKL3t75iTcwo4e3glUpQkVuqmcKGs4Cc8qT3jzSaVg8lF0zCwV5xOAxpl7unNyipq2MO2007TqipY/MCS+i5bxTmaPVAmp4soxoLe0fr+uZjYY+kheUHZkSoFLz2DdAkXW/0zMbILmeU3f+WQiVMcMqs5iDZJiXrwX3n5aXukKiR1vtwFmkLzjYjraj+ysjVvqZcbNxEhqz/DFkxl6GtYrd3syHxCyxc6nYPb2vb4Id57ZZPaziEABKg/DodhYc58BGLsrvzBB7axw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(136003)(376002)(346002)(366004)(7696005)(33656002)(8936002)(110136005)(64756008)(66446008)(66946007)(66556008)(66476007)(5660300002)(26005)(76116006)(9686003)(55016002)(2906002)(86362001)(316002)(4326008)(186003)(6506007)(8676002)(71200400001)(52536014)(478600001)(558084003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1IrmG/tXEtoBl41b5WArSRP6x005s0WoinsMBx6xV3nBJac/kMou+DcDg4eYH13HAU7zwpL4cR76oNF2bZTDNGcsbHasHxlxRX7cXFSthwrmxgxwjA97dmh7S0dZpg9wTThvWu9QTlaVKtt2XSA1yMBomVJ/w0deRws72/gQ5WU4SDVxdbKyMeV/feyc4HBwPPy/v+H9deTHhgXGAwyIeVRbdPNPtModwadvfvbxTX9djRFapDV4aPeUsHS3Vww4ryeGd2i1RTZhvFED4NNpMeuZ35jzAkXNgEPrmiEJTTrIiqJfx5aoWGKIbKVtECmuc2LNcUhx673tGRJqmjmVNYFJxRlzQBBzPFzieQ478UEID1/p+fpYK7PrK/93BQZbElQfHca3L3zyVJx6JbcHnQcDBS9tu3fywNRuY0z2QIYZU9ml+A1yN7YAcr+DroyaNbWXd0pfZGlxQSb1jT3Dh9nNxYTrwEf93TkZWny3jjGhu9Mw7Ge5cA9xrrDFYELl3CSBGyajIE4qFSDIpAXnlKBwx79vTcL/XgBmOYjRT3uPKe3mUqwjAbNL9Zva4GKnNKOQj8PJidNozZvDz+NxwNtmEJQAysWuETX1/h/cCy8ey5SwgApa7SR++vwFbhAFTVTpGY+zsUhCGKEc5aRaGQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c7470e-4421-4127-17d0-08d85a2a307d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 10:20:51.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uROpLLIIGaTRf+8n2HpCaMfsdevC/x1ajStGc/3JuuR7NAymGBfYqYOgiSs90Hi9Jvd4EAZ1nexMVrtCuB8aKAGh6OthJyGYDWHU2u0i0V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3066
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCiANCj4gQ2FuIEkgYWRkIHlvdXIgUy1vLWI/IFBsZWFzZSBpbmNsdWRlIHRoaXMg
aW4geW91ciBuZXh0IHBhdGNoZXMuDQoNClllcyB5b3UgY2FuLiBTb3JyeSBJIG1pc3NlZCB0aGF0
IGFuZCBJJ2xsIGluY2x1ZGUgaXQgaW4gZnV0dXJlIHBhdGNoZXMuDQoNCkJlc3QgUmVnYXJkcywN
ClRob21hcyANCg==
