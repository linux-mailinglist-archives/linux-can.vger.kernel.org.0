Return-Path: <linux-can+bounces-287-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90144857787
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 09:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117DA1F21A84
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F771C698;
	Fri, 16 Feb 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itpeak.onmicrosoft.com header.i=@itpeak.onmicrosoft.com header.b="zZi3uAgJ"
X-Original-To: linux-can@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2090.outbound.protection.outlook.com [40.107.135.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43B1C695
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071577; cv=fail; b=OgiuC9RTVzJDOXuyaznDIqz9A5kRrsXeX2do4Tz3YUa7HzludJWvcLeNSQUbi1sDUv/JguRZbVJqVsb7KfYAjalvVIxx9WXHBV0R/RrDCHeehzOGeDG3ovFOiu1hIdx3pO1WqcEfYMlNGUJfaTVDSYxzNTJvksaKHYaU7jhxzp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071577; c=relaxed/simple;
	bh=EB9auMwBGEvt0QDJgLaghTbcwc/1g/S7vYroCHsMXO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nw7yO4IYAvkoFUFGhl2aGLfAIdM4p+aYlP5kLrXP21z5mZyM/9k1QwnLnAMEmIQ3qNbtHnIum8wASkshnykjhzmxv2e9yPXruvgN8yVQIRRfjr6OQD8LZpaEr1O8SdExUi6u+csR95NFuF2FLAGR3ZYiDIWCpIcEDWMcHD4SMNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com; spf=pass smtp.mailfrom=peak-system.com; dkim=pass (1024-bit key) header.d=itpeak.onmicrosoft.com header.i=@itpeak.onmicrosoft.com header.b=zZi3uAgJ; arc=fail smtp.client-ip=40.107.135.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peak-system.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9rwAa12SAxRkzn7Vo2//0TrYEMdBxtIhREdWq+HRqUQo48pBkzwba1YJEzQcB6pJo86zYM+SwtxPcrSE6DNoWPTouiGJBQqUjebbhOiyHArs0jz1BU1NWB7QlrDWZsSuzZY/9dc1GNzn+gJLNYPlHw9OjqSEEZDw9/Cd3NJSa7MG9Ws6/Vn/qHqwX+RGE1Ku34cOQjXUEGA90M7e5xVYAin7ZqgcsfRhWjOIRhEQMtciIKxdzOZwTzMYV5nD+QWHT5vZzgoV9vlAwEQGKfToMUVJGxSzhgIaHBexTwMymlm4N3+KXT4pRrLd3bKQ21C3P2NmvRfhAF7bWeovJAJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWZ8iTattLTlO3Ac2emn8WL64Ebevyt76Ri9vCXTQnA=;
 b=MvWCpML3a9kWEbZ1V2J8/NKMQY7jI2EhgiWFu/biTHzZIXxcILmw2wPv20S6nZ/gxg5bkIjXgt+cWokbyZ8LTkC/rTUkHc88FkXGBBdG4ApuuHp70y+ZPw1UIZCZGKf8xZtJ/HzWHdmUs6OI6LNBVXvmLbPt4GaLtajwpiscSBK00ndGxl9aiYNIH00xSsxkxOD+RURlULmMKtivQoQngKMAJyJGhaaAoQmwDVEaDJKNSYS8UE0ZM3XgvUQwtqRtS52BxbVBvK0AzLcm/zFjqdf4h7NbktwFVdLxUNH8yNapipATS0XCRNNQ3doQg9Rmo9dW8F0ehUB/7TB+4EDCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWZ8iTattLTlO3Ac2emn8WL64Ebevyt76Ri9vCXTQnA=;
 b=zZi3uAgJKEniK/XSDYIdJWJliR2ENNWjETvemBCKGye/lhrWDoFAgIFNffP3zUwFUt6ML9IWWqLXQxYe16wQq56O15YgWKwn4RrbV19CdlhTX0Z4IULOfxmmLzbmKfIkAWQt7Dz3J4nIoVhHx/lunMoeANav6iKwQzdx/jL5qxg=
Received: from BE1P281MB1633.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1c::13)
 by FR3P281MB3261.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 08:19:30 +0000
Received: from BE1P281MB1633.DEUP281.PROD.OUTLOOK.COM
 ([fe80::81e3:a993:fc9:f5d1]) by BE1P281MB1633.DEUP281.PROD.OUTLOOK.COM
 ([fe80::81e3:a993:fc9:f5d1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 08:19:30 +0000
From: =?Windows-1252?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To: Vincent Mailhol <vincent.mailhol@gmail.com>
CC: linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 3/3] can: peak_usb: fix potential kernel log flooding
Thread-Topic: [PATCH 3/3] can: peak_usb: fix potential kernel log flooding
Thread-Index: AQHaYCN3cEogOjKvnkSbw7T4FxY087EMMTcAgABrV7g=
Date: Fri, 16 Feb 2024 08:19:29 +0000
Message-ID:
 <BE1P281MB1633DDAA6D525B79DA9D97A1D64C2@BE1P281MB1633.DEUP281.PROD.OUTLOOK.COM>
References: <20240215152656.13883-1-s.grosjean@peak-system.com>
 <20240215152656.13883-3-s.grosjean@peak-system.com>
 <CAMZ6RqL=qp9OHVny92Qt9wyY7eU=3dm2aQRChvCBkAfnj2jqng@mail.gmail.com>
In-Reply-To:
 <CAMZ6RqL=qp9OHVny92Qt9wyY7eU=3dm2aQRChvCBkAfnj2jqng@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1633:EE_|FR3P281MB3261:EE_
x-ms-office365-filtering-correlation-id: f6839aad-8ef8-4999-8150-08dc2ec7ff88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7A3INCNjkdfhlaBQAQbcsMfEJ68lSNDP6kA5Sjd7fI8plf4QjibreNjRx0rjkANY6PBE47yehuFloQ2HCNiR+yAc6auucdn1ELnx5rHhrXJkAiEjtVQTY5Yv+TRA7TKRKXP5zldZQChqwCcndKWdQGJgurmY2ln4RpKBfCCa3mWpyEivIa7BafJtj56HCSQgpUdJapw4aq/FPhVbsH66hywJVrtTRmtObxeRe5ReKhl6nD5DIKkSMzD9Oc3RbfzTfGfb7cKySjSVJYHwsl7lNcilpcA6Nynb7G3XkP9ffRPq2tmxdhzaEJptZFxc1oDmMZlh7ktG5B5eZUKnF9jl+FbAZHNxLIOPrxrSqRHiJnirg2HbeLLT+G9vHTZTu50/56idnHjx7J33ZOg36F/0jgeQoUYLvL4PZBUQGhWRONi340Nc4DQKEDIFJwFKlHfOSCi+ZQC0fhx4ppGMGvHEsrYYEE0K/sCedg/MhfeQB4bvlLRroSxEeMd4FkGzt7SW2Q5NswCwpE85oORzXj79My7Wf3COmGJirERq6mcdEPltWk8PydsAzanlzpKkO4MDcHxeShu8yv2IxROkO7xv1spWlbe5LjlZDv9pq8/2eCI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1633.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(346002)(366004)(376002)(136003)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(86362001)(38100700002)(122000001)(55016003)(41300700001)(5660300002)(2906002)(66476007)(66946007)(64756008)(66556008)(91956017)(76116006)(66446008)(6506007)(966005)(478600001)(6916009)(9686003)(316002)(71200400001)(66574015)(83380400001)(7696005)(38070700009)(8676002)(52536014)(8936002)(4326008)(15974865002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?TxP6cQC/VcR9msYgosAIp98LpHke7gJKHMyJi5z7ryXJ0limR1r5zmJ1?=
 =?Windows-1252?Q?TMTPJ/NO73x2NkBVDBmie6G0kjiU3cswy7WB9Fyyr6wxxfdHDMNdBxOf?=
 =?Windows-1252?Q?DS+9sqMHjTuQxMpDm1EiyJ3C1z+hqmn0EAZtPRCNE6Tr9Ah/qKYVgNin?=
 =?Windows-1252?Q?Zib1av80mmbkHWEc9SW/ccXtptomFv6IzdqcIGfTXpaqXYzNwJhDZxpG?=
 =?Windows-1252?Q?COBt3V7DCVfkgUIutx6/zdcA0r8bHscpviSciVwWPze857yzoihKTJSV?=
 =?Windows-1252?Q?cah1vMEUBOoLGHrL1zgRsbjLI7ytvGVnuWFMuVGYRAkmmznZ4r00weW8?=
 =?Windows-1252?Q?wbFRH3mCd8rqEGQhnLkpztuMDhJU1Vnb36VpcaeA7SV5TZmAd+WK/DZH?=
 =?Windows-1252?Q?xLjWdthPcBlHW/G1t1cHNy2d7Fl424XY/tRjBH/xWIfeUtEHeJ0v0YAr?=
 =?Windows-1252?Q?Ugc0gQiokRMJJZ6qQmze6uk9FGrCeGgDlAPdDr4HLnyOAIW+HqrXfoIB?=
 =?Windows-1252?Q?0bqpAVGn7qf2Kmaxz3f0RzFnBBGfx0gdpm+bQlLssjXOkndOf+Ue6n+c?=
 =?Windows-1252?Q?8W+T4eoYdgcipMm5LgxMEWv2TNSdBoRTCh2NGZ6u+ACuGrYmcjl+sQ/c?=
 =?Windows-1252?Q?g6h0gbkeDz07FCgl94ywOUnQBNoo1ZvXgyCLyxmXWCsiXvrTbULVfFED?=
 =?Windows-1252?Q?22uGsN70ltDDzxmNPstcO/EscaJE1ljxj/lPqmdU1Hdkg/o5twm3yKHK?=
 =?Windows-1252?Q?LDU4X8TWZVFd2/PjR7lZiJIFEImSmOC6TARsro06LVWS6+/SPq/rIpAF?=
 =?Windows-1252?Q?+DHxgzpZ6S2gWH5kpz0PejOKhVRFDV0OhSnzO6mbZNXtdZp/xiPqNQ9p?=
 =?Windows-1252?Q?JxDNSz34aU4cfAfCeJ3Cg5BzsXYiBx68Z5SASPLM5fEpcbZh69QWzoSF?=
 =?Windows-1252?Q?GfRDJ3FAJuOI7xqQX0qpFkk2h7DMa8cAFDOpZaYl6WHZE05BDTtTm6yG?=
 =?Windows-1252?Q?AlWYjMP8C5tyzk0+2BglwPKlT+3okDmWrOspFJwe0M5760h8cgKN75vs?=
 =?Windows-1252?Q?470QbbGJd5VAR9UtnSdrBmtiDebaor2eUYEzWQzphZa0/xVH2cttatpq?=
 =?Windows-1252?Q?VL4jqFK2OI4nhvu2x6/2xV+CNNSvL+tEbGv0f9lPV60qfDOEvIZ+IWwm?=
 =?Windows-1252?Q?AUznVQLwe+Ka75Vx+KsvX49UTUtw4N7l8cAwVpe6lJ3kvcgTb3o0pxkO?=
 =?Windows-1252?Q?nSQZh5wJag24MegA14ehzJcOMh9bBdkcLBkYeNP6iniypfQgiwDaKdXn?=
 =?Windows-1252?Q?nIXM84NSGRGVeOhaxwP4dkKlIMWwChNllwj82IGku9P2B2zqDerw5CNM?=
 =?Windows-1252?Q?vwwx9JJGN1Puv0acikPNZLIGZUi9Zozq1ObcBCev+Dl6u1MjoM93BTj+?=
 =?Windows-1252?Q?kmF1IOBomr14uWuiaI3An+l6J9GnrY6mb8FDtFZEOVJ/YwIRyhML3YU9?=
 =?Windows-1252?Q?pRzKvi2aa55HLOu0D/mcNW+Mi0KPKry8W4v+Hb72OyQtDR4F9Q3AqXbB?=
 =?Windows-1252?Q?v+2CnoIi3dNApgdKw5zvo+TbmrBOcSSUCKJPS5Sfxerlw9iyg3tk9Elm?=
 =?Windows-1252?Q?RajzQH4W567S4XNSUeNPlLZBOSv+XKKmQPwttOJjQWqe386AxdzjnJ56?=
 =?Windows-1252?Q?XMjb55dc7ImiPtL/PIK6XKxejSkazgLQS7xCK5hHx8ajwSkAowA8Zszr?=
 =?Windows-1252?Q?VGhHHodlf3DozLJt1aXrV8UDbVQkwhaCWT/fzUfqXW+iy1n+K0CAIU0A?=
 =?Windows-1252?Q?UZYGSA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1633.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f6839aad-8ef8-4999-8150-08dc2ec7ff88
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 08:19:29.9774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEapgMmkUgjSDvG2ZVCEgP2TmoRNti3CxFh63pmSkvWOYaHlbEvpdgx2KV4CL4cBGQU2unKyav7vE+AZMEOtjlCqcbaA63fwMloYje3T9XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3261

Hi Vincent,

Oh ok I didn't know this facility. I'm pushing a new patch that includes it=
. Thanks for that!
FYI the frequency and number of these notifications means net_ratelimit() m=
ay not be enough in the long run.

=97 St=E9phane


De : Vincent Mailhol <vincent.mailhol@gmail.com>
Envoy=E9 : vendredi 16 f=E9vrier 2024 02:37
=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>
Cc : linux-can Mailing List <linux-can@vger.kernel.org>
Objet : Re: [PATCH 3/3] can: peak_usb: fix potential kernel log flooding

Hi St=E9phane,

On Fri. 16 Feb. 2024 at 00:27, Stephane Grosjean
<s.grosjean@peak-system.com> wrote:
> In rare cases of very high bus load, the firmware can generate messages
> warning that the receive cache capacity is about to be exceeded.
> This modification prevents the driver from flooding the kernel log with
> messages and memory dumps that are far too verbose in such cases,
> by limiting their production to once per session.
>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index a1c339716776..d444ff0fa7cc 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -70,6 +70,7 @@ struct pcan_usb_fd_if {
>  struct pcan_usb_fd_device {
>         struct peak_usb_device  dev;
>         struct can_berr_counter bec;
> +       bool                    rx_cache_warn_handled;
>         struct pcan_usb_fd_if   *usb_if;
>         u8                      *cmd_buffer_addr;
>  };
> @@ -667,6 +668,28 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_=
fd_if *usb_if,
>         return 0;
>  }
>
> +/* Handle uCAN Rx cache warning messages.
> + *
> + * Such messages SHOULD NOT occur. If they do, then this might come from
> + * massive PING host flooding that prevents PCAN-USB Pro FD HW v4 to han=
dle
> + * CAN traffic anymore. In this case, the driver itself manages the disp=
lay of
> + * the warning message.
> + */
> +static void pcan_usb_fd_handle_rx_cache_warn(struct peak_usb_device *dev=
,
> +                                            struct pucan_msg *rx_msg)
> +{
> +       struct pcan_usb_fd_device *pdev =3D
> +                       container_of(dev, struct pcan_usb_fd_device, dev)=
;
> +
> +       if (pdev->rx_cache_warn_handled)
> +               return;
> +
> +       netdev_warn(dev->netdev,
> +                   "Rx cache size warning! Possible loss of frames\n");

Did you consider using netdev_warn_once?

  https://elixir.bootlin.com/linux/v6.7/source/include/net/net_debug.h#L46

This seems to do pretty much what you want.

FYI, the net_ratelimit() may also be helpful here:

        if (net_ratelimit())
                netdev_warn(...);

> +       pdev->rx_cache_warn_handled =3D true;
> +}
> +
>  /* handle uCAN overrun message */
>  static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
>                                       struct pucan_msg *rx_msg)
> @@ -768,6 +791,14 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_de=
vice *dev, struct urb *urb)
>                                 goto fail;
>                         break;
>
> +               case PUCAN_MSG_CACHE_CRITICAL:
> +                       pcan_usb_fd_handle_rx_cache_warn(dev, rx_msg);
> +
> +                       /* Rx cache warning means possible overrun cases =
in
> +                        * the device.
> +                        */
> +                       fallthrough;
> +
>                 case PCAN_UFD_MSG_OVERRUN:
>                         err =3D pcan_usb_fd_decode_overrun(usb_if, rx_msg=
);
>                         if (err < 0)
> @@ -885,6 +916,11 @@ static int pcan_usb_fd_start(struct peak_usb_device =
*dev)
>         pdev->bec.txerr =3D 0;
>         pdev->bec.rxerr =3D 0;
>
> +       /* warn of a cache problem only once per session, to avoid floodi=
ng
> +        * the kernel log.
> +        */
> +       pdev->rx_cache_warn_handled =3D false;
> +
>         return err;
>  }

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
GL: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung finden Sie hier
www.peak-system.com/Datenschutz.483.0.html

