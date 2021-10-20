Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64B84345B9
	for <lists+linux-can@lfdr.de>; Wed, 20 Oct 2021 09:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJTHQi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Oct 2021 03:16:38 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:30478
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229817AbhJTHQh (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 20 Oct 2021 03:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMeLKjpNPRuHupubBNVv+OpjdsYPpWboSGiHyEF3MPWAqLBRHQ3vmXurh54sx6vj8iE6ksaCt7l9eZBpaz6qE2FaN9EoRWaLGdtfNGWBRnlPqsczkFQMS1ZBOn329iT3ZZnJQdIKzD9+Yy0B3nuRFfBY17l5fpwB4bVLW5r+VQeyzZkrKtTNB0ZX0/yNEkkPla9JdgsJcdbHTwZm2oQDQDCSXEUUdGKDRyPetFSX28I1+B+11DEPnAeuPSobNmQY58WVXkCjDZAN7g0Ap4M8Qs5O1339H00wSh7JIirdlH9wgp0YUuyX1aUuU7kF3gR28mv6kEegCeBhanxOnCDkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIcngtSUqXbRjBit+QKq5B+MleUrA1oNB0Qx9cVerzM=;
 b=QcFNe7YQWy6bHl3JiobfR1G+5WAwSZZmttG4edxsxQlDqQxoslOOAZzQh64UkB8r1AgliNXwIIm9AyodpG4w2ZNy87tez9YlnC95hWO4Jl1HfqTqzBxklcho3kXizbn11yIxy0KdHvNDlWyXol5FOot6aYY75qS/cNaK3h8sL7rjFZT6d5toYOAWzP0IYtHPdvgMbio1b/Zt1wxPckQwHva0RA/+FIxcnY9z8o9FmGM7l8C3ZvbmIkCt4NVN6umeCIZvFG4LD2xU3HvmG6yR3Jk8dcsdIpDa1NxaQ/z+FFlIgEX5R8tq5ZmRvS8fW3NV7TgXGIf9amFcvcvclS7n/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIcngtSUqXbRjBit+QKq5B+MleUrA1oNB0Qx9cVerzM=;
 b=aeM7gUwkaiPb5Q/VxNDY3K+RAf4Q38FZL18en52YIZqpKLkOq6/mFpLZeBJW+zd3Eg1MJrIPbv2/dBwwH78elResexWW6iXX9IkFNYHSZ6c/XlF+RWWtvbUb1XqCS3GXDSaibAu9mYK+D1H9AtKdKUCrcvsEPRxO60fkk+oUzIA=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (20.182.212.73) by
 PR2PR03MB5210.eurprd03.prod.outlook.com (52.133.110.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15; Wed, 20 Oct 2021 07:14:20 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::8442:8aef:e942:f813]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::8442:8aef:e942:f813%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 07:14:20 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [RFC PATCH] can: peak_usb: CANFD: remove unused timestamp
 infrastructure
Thread-Topic: [RFC PATCH] can: peak_usb: CANFD: remove unused timestamp
 infrastructure
Thread-Index: AQHXxBwr6idrzqKtMUK7zrm4y+bVZavbWPqw
Date:   Wed, 20 Oct 2021 07:14:20 +0000
Message-ID: <PA4PR03MB67977F6773983F04C7F0EB5DD6BE9@PA4PR03MB6797.eurprd03.prod.outlook.com>
References: <20211018123203.2234904-1-mkl@pengutronix.de>
In-Reply-To: <20211018123203.2234904-1-mkl@pengutronix.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c01168e1-2280-49c3-d29c-08d993993cb7
x-ms-traffictypediagnostic: PR2PR03MB5210:
x-microsoft-antispam-prvs: <PR2PR03MB5210B888FE1F379CCA7A76B0D6BE9@PR2PR03MB5210.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mhwv8uALKcPdVe1Bj+yExfo1yRTNEc9UhaI1Af3rGxdGXKYLZ+eGS1TPRspc8lDajRI0C02/7ANRMfbqsHn82I3lLLXzqImlTNTzOF0n7XcpRsXcyrxB49qXced95h9mE5h+a5Fse7rrmc7CkFUqHRlE771Kb6y8nB1olGD6JhZ9TZA34V5eeGCW1v4jHIKH56sdMQMB2BwF4DOpSrkewA7NkJFtmRzOdYUmGg2GrPzuTnPdGpqWC2lGUZu5o1DzigT8moFVy7NuQuEN0JN14ucW5thGv1uXiZxU1oQZhxQaav3X/KR2qXXc/RaLcTAPMJHELZkoxqBHubf3tKUFRDB+8YdcitSx10o4C9g9bmAep6EngkFGpBTI2XSdYUorcqhyFxipqQl+lqeKh/1EXdo27OOaKoXq3tlqtMHXldvu36/OSgWfQsu6pkoTtI6PAHhyW+KzuAXwNBYMgFH4srzpNrhOSGU6iejKGPKyP4ADXA0Fn53hvgNaVdpxNcS8KbfmQBc3AH8uYIuDd78BPlJzlXr4/c/aNb+X7oUhb92RBfw99g6PArdaH4bXNJtRpVCvi/OqoZxgF6BugiTDRzxaeXMuamTtiG4x1Dm6STEOc4/oVJM5wPZb2kTlF35/bXywxm7oqJrm64hKro40snoeJhHJ/fEq5SElI1gTiZ0B/p5hbYtc4zMYS0se41BEBQr4lQsAgBXSCi2hYOKSzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(396003)(376002)(346002)(366004)(86362001)(2906002)(71200400001)(186003)(38100700002)(26005)(8936002)(66946007)(7696005)(6506007)(38070700005)(8676002)(9686003)(4326008)(52536014)(122000001)(66556008)(66476007)(33656002)(55016002)(66446008)(64756008)(76116006)(66574015)(508600001)(316002)(15974865002)(83380400001)(5660300002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n0I8pmGPJM70TFUR0QQol5689gNpoMJ/zoL9SsEW90vQisix/4hbAQoN5Y?=
 =?iso-8859-1?Q?oLQXqugDnUqateo9PFEA4+bSgYjmLMwO2m0uK+BfQWpI0tNdj2c/LdmzpS?=
 =?iso-8859-1?Q?DM8OwY7ufYqo62bAjkWT7DP3pBcUi56NNs85dTajUny4tAp7MIRMmGVuMN?=
 =?iso-8859-1?Q?b/jpGe85rNuB1kVzdKDrJcd3RNOaLE0G3baHWJlsRZBrhlxuUU/z3gOhhe?=
 =?iso-8859-1?Q?wIkLnxs78iIssM3uuVDX+A+TA2bk7QUMEiOXdLu/y/ofJf5gJezSw5zZU6?=
 =?iso-8859-1?Q?2BDnSpqGJV2GdRY8CBz7/xnRaxzby5nUq/5gZcOH7cTA4f6XtHxacXtkNN?=
 =?iso-8859-1?Q?I4iE8agRgSEBDj+Iy3E1xEx35Z2FHlJQoAw1ghlb46bPbFlzwo4T5350Kv?=
 =?iso-8859-1?Q?ta+B/uu+coTmIYtq3qUcCxoMKdFVnTFz1v+u9zo2vQ1cqc6KUusD4SVl3U?=
 =?iso-8859-1?Q?z6pG1psRi8inl15dd85uWL2QbK+yc3XLCzNXTuPEkIP+vJE7AdwnPStrtX?=
 =?iso-8859-1?Q?eWtWPdPmieVSe9e+TLQTjkHGREjEL8z0htNqFGPbMY4qfYPeiCkvS7UahP?=
 =?iso-8859-1?Q?f49U1P0cEUVt6UZ/GPbHf6atRjavyquN8CHdcs4cp495xCE8A9w9UEqLlX?=
 =?iso-8859-1?Q?4pvTR+OLToM3m0QaPWTrV+8UJMIL2HJQR/2pmyuYn0P0GneTeAy3B0lYj6?=
 =?iso-8859-1?Q?MhEoig+wOQGaAGVxGrZzSAChgMlEc8E3s/XUGq3QeCDNk8NjkGCJTTvS7u?=
 =?iso-8859-1?Q?hQRzGXmoyE7qYW3RNlZ9tNzz0FF8qWaBK/TFbybci0X4XKdyLnSCAOxT50?=
 =?iso-8859-1?Q?jHKgPR/Qdl6dkRy11PLd9d9aCQlzLkNKVz9awU2MA2CiRFpLkA84whe+In?=
 =?iso-8859-1?Q?vrs9GagLoZuo/ROaBTvmBUL/oXmZ2VM0GBMLEkKJaefadAADyl5FmrXpdW?=
 =?iso-8859-1?Q?IeZOHk35n5FQubLk/qvRM91OgSsc+0bgxirc9LOUS/14ZPY4fnv6uCwKSh?=
 =?iso-8859-1?Q?+UgpRP3Ogkhs1WrQEuzqAGpLNX5yDADL8nAXKrJ7uXX7TfliZwku3gmxSb?=
 =?iso-8859-1?Q?5fexSFxMb0Q9VMx7HHNJH0LrZJ7rIADAuFn1SgiV4a7hbV/VUUygOQNlRk?=
 =?iso-8859-1?Q?84sc2SLwYv+5cBCP4OeTn9dE0f1k6/MfpEnylAs2/ZAkLPHNJBDbTymtXW?=
 =?iso-8859-1?Q?VOTKgXYIDtRxDIZmRx0jTDF5lzsBruKt2FDmjhASUPBUL+wmBX3LASWiBL?=
 =?iso-8859-1?Q?4MBojeak41+n2/fbmZtv0FC2pPDGagbBjV4zJdKK8VDmvrdDeDc8wZKFTe?=
 =?iso-8859-1?Q?Go+0lkSzUn0z+GLSTpkg+wBbGPxzhsDgiZ/NxChAAo0jQqE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01168e1-2280-49c3-d29c-08d993993cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 07:14:20.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s.grosjean@peak-system.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5210
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

Nice shot! I confirm that all of this stuff that converted 32 bit timestamp=
s into self-made 64 bit ones is now obsolete for the CANFD - USB interfaces=
 from PEAK-System. However, note that requesting those PCAN_UFD_MSG_CALIBRA=
TION messages is still mandatory to get valid hw timestamps from them.

Thank you,

St=E9phane

-----Message d'origine-----
De : Marc Kleine-Budde <mkl@pengutronix.de>
Envoy=E9 : lundi 18 octobre 2021 14:32
=C0 : linux-can@vger.kernel.org
Cc : Marc Kleine-Budde <mkl@pengutronix.de>; St=E9phane Grosjean <s.grosjea=
n@peak-system.com>
Objet : [RFC PATCH] can: peak_usb: CANFD: remove unused timestamp infrastru=
cture

With the support for full 64 bit timestamps the old timestamping infrastruc=
ture is obsolete. This patch removes the left over bits.

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 13 -----------  drivers/net=
/can/usb/peak_usb/pcan_usb_core.h |  2 --
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 23 --------------------
 3 files changed, 38 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_core.c
index 6107fef9f4a0..9411a76f315c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -192,19 +192,6 @@ void peak_usb_get_ts_time(struct peak_time_ref *time_r=
ef, u32 ts, ktime_t *time)
        }
 }

-/*
- * post received skb after having set any hw timestamp
- */
-int peak_usb_netif_rx(struct sk_buff *skb,
-                     struct peak_time_ref *time_ref, u32 ts_low)
-{
-       struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);
-
-       peak_usb_get_ts_time(time_ref, ts_low, &hwts->hwtstamp);
-
-       return netif_rx(skb);
-}
-
 /* post received skb with native 64-bit hw timestamp */  int peak_usb_neti=
f_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high)  { diff --git a/drive=
rs/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan=
_usb_core.h
index daa19f57e742..ffc2be6ef881 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -141,8 +141,6 @@ void peak_usb_init_time_ref(struct peak_time_ref *time_=
ref,  void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_no=
w);  void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now); =
 void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t =
*tv); -int peak_usb_netif_rx(struct sk_buff *skb,
-                     struct peak_time_ref *time_ref, u32 ts_low);
 int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high);  v=
oid peak_usb_async_complete(struct urb *urb);  void peak_usb_restart_comple=
te(struct peak_usb_device *dev); diff --git a/drivers/net/can/usb/peak_usb/=
pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 2770087d4d5d..394f4959a515 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -50,8 +50,6 @@ struct __packed pcan_ufd_fw_info {  struct pcan_usb_fd_if=
 {
        struct peak_usb_device  *dev[PCAN_USB_MAX_CHANNEL];
        struct pcan_ufd_fw_info fw_info;
-       struct peak_time_ref    time_ref;
-       int                     cm_ignore_count;
        int                     dev_opened_count;
 };

@@ -642,19 +640,6 @@ static int pcan_usb_fd_decode_overrun(struct pcan_usb_=
fd_if *usb_if,
        return 0;
 }

-/* handle USB calibration message */
-static void pcan_usb_fd_decode_ts(struct pcan_usb_fd_if *usb_if,
-                                 struct pucan_msg *rx_msg)
-{
-       struct pcan_ufd_ts_msg *ts =3D (struct pcan_ufd_ts_msg *)rx_msg;
-
-       /* should wait until clock is stabilized */
-       if (usb_if->cm_ignore_count > 0)
-               usb_if->cm_ignore_count--;
-       else
-               peak_usb_set_ts_now(&usb_if->time_ref, le32_to_cpu(ts->ts_l=
ow));
-}
-
 /* callback for bulk IN urb */
 static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb =
*urb)  { @@ -695,7 +680,6 @@ static int pcan_usb_fd_decode_buf(struct peak_=
usb_device *dev, struct urb *urb)
                        break;

                case PCAN_UFD_MSG_CALIBRATION:
-                       pcan_usb_fd_decode_ts(usb_if, rx_msg);
                        break;

                case PUCAN_MSG_ERROR:
@@ -811,10 +795,6 @@ static int pcan_usb_fd_start(struct peak_usb_device *d=
ev)

        /* opening first device: */
        if (pdev->usb_if->dev_opened_count =3D=3D 0) {
-               /* reset time_ref */
-               peak_usb_init_time_ref(&pdev->usb_if->time_ref,
-                                      &pcan_usb_pro_fd);
-
                /* enable USB calibration messages */
                err =3D pcan_usb_fd_set_options(dev, 1,
                                              PUCAN_OPTION_ERROR,
@@ -880,9 +860,6 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev=
)
                if (!pdev->cmd_buffer_addr)
                        goto err_out_1;

-               /* number of ts msgs to ignore before taking one into accou=
nt */
-               pdev->usb_if->cm_ignore_count =3D 5;
-
                err =3D pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
                                            PCAN_USBPRO_INFO_FW,
                                            &pdev->usb_if->fw_info,
--
2.33.0



--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
