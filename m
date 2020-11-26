Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B882C5432
	for <lists+linux-can@lfdr.de>; Thu, 26 Nov 2020 13:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbgKZMsl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Nov 2020 07:48:41 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:1377 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388958AbgKZMsk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Nov 2020 07:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606394920; x=1637930920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TCG/mYqy/13EAPWkTF+kh3AaZnVZw6+NsOSM2qHza68=;
  b=LDwV4QcVtAgw5gzjLB88rr98YZ25SwH8x2FN4+3DMBqpstHhpFKDQQIA
   96B+LUbPO2+lHEnWSiCP8yNL4QcLHHV4gbEUl7j9Au/1WI6VXYyXdjudh
   wXoby3+4VN76wxvhqg15qDYta6etX0j+nngf+OIbGlKayKgeyeST6EARP
   epc71PrYquDfJEJpHIgj/vhEL5huLcaoHi2iJyjVavfpaOkmqszwSfo3c
   mBvUiXWKjrIGJh6FmsLTknjc2lrNjqfOwKpLPe/4pfPjnpuCQFeiWN3HB
   9wCrmMcMnlfg5qIqO270HZ4MB0cfxXPA+h50oqJ5t0y8EOpkWPvyjmfpc
   Q==;
IronPort-SDR: MrI5M7MsYBAr/PP1wvUphfIY55lIHg5gbuHY07TKxthcsJJc/K28bOFzHg5ebXJ6J2Jh2ZRwTI
 ZoGWZWjYA8LoUzufzHRMNAzmBFxoeXukKnPHMxwwO9NBbWES8pX96Lm8QI1vzq/nlUCf5zBG9b
 5k3bdg4Gk3Flc57I375GYDA+FyO4hMf7qXxiQdhApvxG6/9tjVXNl83yNQvBl6ujn+qUZHIC+v
 NiDRb5LX0RnHvLZDtqkJNZAv2yckP5By/iBR+kjRAQ6ZBdu5E4mFAiS/ietmfUiFCxQmALpUuY
 Zfg=
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="100495757"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2020 05:48:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 26 Nov 2020 05:48:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 26 Nov 2020 05:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6jtBx7d/xvXdPeICsTuoM/0A4MgnTKQEnxwJweb079dl+2OtdbV1DUUD/qaPG3bDM/gUAXUGh0lVOgme4LJgN9KUtwJJRnZpL0m5gLn4FEVoPTbqOzI7yDbCqQF3aKDv4ls2l21PA2CyaIZmK3D/aSSmIhFW7osgIyW6/71ClVxOmCtoWda7CBD9GIIinVwocaWjY0XarBKIlgoTqm3Msq79e7GF93u9ierZIBZ8SbU6Jsugb2oBGm12qYfwWLeTIEaNbOIAkmr/wVurrDIbZn5b3ubKxidIYXkVSODpFeiuIz29V6z3pUVFSW092umpPBmGkSuW0FPGeSBu12TpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCG/mYqy/13EAPWkTF+kh3AaZnVZw6+NsOSM2qHza68=;
 b=nyAhiQIfP48SbSq7YLxb7KQmPTOIKELrP1c5uTGakIOsSjBskw8Rh6NBb0vAjz9nZeMAJLSgKuFwUg8TldTtMHWkpPA839ZwgkKZUDWU13CFhbrt1W9F73Wlth32MNcP2bDxzUqVt3ZB3XzPkiS8n4G1t1u4fg9X8vaUac8pGNkx2F3i0SFtlAzfYqvg+KuT0uYIvj/3cJh5VRFcelzmkHQcwTIhArDaKQrz3WFm5iBOJQeO/iJO1w5Gb0D2M3PHRrVGkj96xtxMjY7is8T/RcalSe+vX/xDN3FH2+gO4liA+ZX76b3rVSINXnwVwiSIOBqppggQGi+59N8kGJle0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCG/mYqy/13EAPWkTF+kh3AaZnVZw6+NsOSM2qHza68=;
 b=jIzJ1eNUcd2H0Qdg3v4hDvOTGWWHR9dkl+LsmH3t8oJ7r6X0B9d0XQFhQro6q7HvioVCLVqQhmlaLYKZJaFgtdtc5z2iW4MjOCQvzPRBZZ+YtGuzOBovpfrrxgOX6b7UlbAmrKrl4kwE0izJcApm8EvCW1BsAQ2YG+SeBemo46E=
Received: from DM6PR11MB4283.namprd11.prod.outlook.com (2603:10b6:5:206::32)
 by DM5PR11MB1691.namprd11.prod.outlook.com (2603:10b6:3:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.23; Thu, 26 Nov 2020 12:48:36 +0000
Received: from DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::579:186e:a296:9d2a]) by DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::579:186e:a296:9d2a%7]) with mapi id 15.20.3589.029; Thu, 26 Nov 2020
 12:48:30 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>
Subject: RE: [net-next 0/3] tef-path: reduce number of SPI core requests to
 set UINC bit
Thread-Topic: [net-next 0/3] tef-path: reduce number of SPI core requests to
 set UINC bit
Thread-Index: AQHWwzrb6I4D9ktn9kmrtJVCtJ0Zc6naXXHw
Date:   Thu, 26 Nov 2020 12:48:30 +0000
Message-ID: <DM6PR11MB4283F5E8A6585219982A2A31FBF90@DM6PR11MB4283.namprd11.prod.outlook.com>
References: <20201125145221.22241-1-mkl@pengutronix.de>
In-Reply-To: <20201125145221.22241-1-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f3ac009-af17-4eed-d5bf-08d8920993b2
x-ms-traffictypediagnostic: DM5PR11MB1691:
x-microsoft-antispam-prvs: <DM5PR11MB16916AF43FDBE6C7B9F767D4FBF90@DM5PR11MB1691.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ictHsdzHKdeK1MPDU2fPRZV0PrSLd6XKH87vdCVgPEF3rD3Jt9rh3hj/mUvqmykVZUdxQbXrRn9T01Bf+w3/Cr5d/wlITEmOL5UXq4JzsPEpk1U1RfoB4kRpkgEaDtzZPYiLuL2LHydCcd4xejrVCCGnUIjYNfiXqqn9tvf+kVGlqpQztpaNi37zngWPnlsz3n2BIz4MT/HesIF9XAhb5Pc4qyJLJGBpghigyiXWbeEDIItWVyqzrObafmw21XWReSs4C2elyxiFLVVFYCojIYSC+F/2iD5E0rOvY6kOhDIDjrjPYEaJdPG6f9vLoxYN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(64756008)(66946007)(7696005)(66556008)(110136005)(71200400001)(66476007)(5660300002)(66446008)(76116006)(86362001)(8676002)(2906002)(8936002)(316002)(4744005)(478600001)(52536014)(83380400001)(33656002)(186003)(4326008)(26005)(55016002)(9686003)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IQBD+xtjsaNzjliIr8AwxV8z08gB/VwL1UCv15C0yZcwQMlu1+GqWqJDOl2o?=
 =?us-ascii?Q?VWT9sfYYwbX/5Zlijol9x5pJ1SR0mpKlZOBZnP2KWNFMuJnJTvJ1KQ9FJjW2?=
 =?us-ascii?Q?MgNrsl71dY6QhEH7ZBCIHZ6Zdqk+7g340eelJs8JDC5T9Czjz7idxHMHZRsT?=
 =?us-ascii?Q?pOu3sy4YYf3cZFQPbjaHULjAlz3G44gVZg0RfFYjuoVT7YcqQmMJVCad+5gG?=
 =?us-ascii?Q?mzXa0SITqkqMjUKq7TJx2SC0joO3A0BUwrqMWi+DKSXm5/hKgrpE01jFu/At?=
 =?us-ascii?Q?TY40FZFNH/FKwJaLJxm1z0LUO5i5HE6vzErbY3kiGVymlwBluuGndPdc01/b?=
 =?us-ascii?Q?FiEpv1PPaGTgWPLD2qmDwPtrNXafA/Uyd/Y/MD1+R4ivO40Y7iMowGzi2KZk?=
 =?us-ascii?Q?YVDVvoKyMnWEUsKtBkSxkX93yuLxFb4ESBMrk8qBGEZ0grSL0ImjW4/opEEX?=
 =?us-ascii?Q?EV9Ma2qa/bTqC+GL0B5Tn9/fjdWiqGQEGYYHW3ivVAlWBruENdka+AF0VdGT?=
 =?us-ascii?Q?Ch3GkQ8mJ5bFStEkS2IFyU6Lq5F2PDh4IqyTxW75fR9swc+wtj2zvKEIsMVl?=
 =?us-ascii?Q?YK903WwpONRboDHPxUQ2wY1Nz13FxXy0woHtpdaLxv54ITGPOltQ2rWk0Zd5?=
 =?us-ascii?Q?fBCfDkAUIiSxZsQdYgrBbXRVD+bFiv78D1NJqYH+y0GfmnX6lKywyw/WdPlg?=
 =?us-ascii?Q?PIHc2Lts4fKQowKdUi6LChtvgNLwL+xLHX2WRen2rqgQRG+6OdOKNurkSPQl?=
 =?us-ascii?Q?z4IqAtifZGCUU6zccylir6/ZwrbK3giWdqAzJAmV8NZiW/0QUru1/dBbAGOt?=
 =?us-ascii?Q?0BC5vs78QQek/05AdqLZylq4SFPviKB/w5TUjRxzkzstlqJCEkGzAYNzVgnb?=
 =?us-ascii?Q?mHHiH+ugvF36UmEsLMqJal1rzspuzV3vzQxf1bAON40IN4vHZGlcosJ07pIZ?=
 =?us-ascii?Q?EH/RWQ0RTiljkiKPqPn/kOqn23atI+gGDtsUj2sDv34=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3ac009-af17-4eed-d5bf-08d8920993b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 12:48:30.1817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwK+J+2LWc+KdIMj3YqzavKdTJU5jv/rYtQ93I2GJRGk//dHHtPj8nL4UzfD8txvdFmRMM23gCF817cLYMwDKiQlF8O4mbklmAEZvxvyO7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1691
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Sent: Wednesday, 25 November 2020 15:52
> To: linux-can@vger.kernel.org
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>;
> Thomas Kopp - M43677 <Thomas.Kopp@microchip.com>
> Subject: [net-next 0/3] tef-path: reduce number of SPI core requests to
> set UINC bit
>=20
> as Thomas wants to test the rx-path improvements, here is the same idea
> for the
> TEF-path.
>=20
> This is a short series to reduce the number SPI core requests to incremen=
t
> the
> UINC bit after TEF handling. This is done by chaining the individual UINC=
 bit
> changes into a single SPI message consisting of several transfers.

Thanks for the patches!

Tested by valid for both this series and can: mcp251xfd: rx-path: reduce=20
number of SPI core requests to set UINC bit series. Tested on Pi4 with=20
MCP2518FD and MCP2517FD.

Tested-by: Thomas Kopp <thomas.kopp@microchip.com>

Regards,
Thomas
