Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4DB4D30CB
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 15:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiCIOHM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 09:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiCIOHM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 09:07:12 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9986117CC72
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 06:06:09 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2db569555d6so23600987b3.12
        for <linux-can@vger.kernel.org>; Wed, 09 Mar 2022 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qS2KIfBzApn+HZZ2Xl8DU6y5zhsrZJNVqjgCAalUK+Q=;
        b=WSHLUlwzt3ID5QDIQ0jXOzA1gTFCNoBouFsZyNxOA1r+HowWwxo01DDcZxS4IaVYFL
         O11Gzx8dNsg/ycay15uF2ukIPzrDieUU9hd0g61uTgEBTGLZbuhp70NFUK8Qm64XLSNs
         5SyF7hN/YDiXKVb+Yd0Ay+BNAOZOGM/Y/y0rBLM9iAlDrE+i2/UtjZHeLUq9Vm/uL+BZ
         EqeZo4wcp0njRd3UPZM6DRr8VskOzcOkRgv1JAwHc+p8YnFPnlkGpAVyc80kCn9BNBHx
         6MeWCz6BRpqbIifV89un9wg/vo7p394fgvrxni2mfNpgXs/NICb1oT0OHH8Uxi0DCv2t
         Rsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qS2KIfBzApn+HZZ2Xl8DU6y5zhsrZJNVqjgCAalUK+Q=;
        b=POMNdKrNPGqxx1dK87YZronkpI0TXqKkWdp4y+A25W9UQfM0UiAYpwiJXJSAP92lHC
         eVvcHglq9zJidlU9zyX5PngL6kSv3vyIhxKjZWwPoy9TQVKT6pQm9vRvFk2kYZWo9QSX
         x6kGEaENj/JfsXE6WK/mbCRk/F1VV5c+o7PN+86/Ros1kw9btEpv4mFAzjJgERWYryB2
         LymxGEYLNPzbzic9HRUS26jxtw9UEvHTDnbk4XTNdndo73B89xb26FkfNI7t8R842Q5w
         qVyo3C20dg/0bYf5Ycrp2yZ3Xh0dD7K3As8rGshHKRGc0ew1cZM2gW/Cai3TxCriWQRL
         2Alg==
X-Gm-Message-State: AOAM531v/4UgLhCNj89LDUwMqrQj2DlHyoKA7geuU1aw1oeWJudWp6sm
        A/49Jt70iYy8Sr1sr8gsqJRLHmlOd0TQOd8fDyY=
X-Google-Smtp-Source: ABdhPJxGM639Tf6BoxeN6hZEbWCFOzXo9fpuycZzbXLKR4FRRXiyB4u19xEzfiA2aZ54JQdoYBjQW5tk6wGwOly5UVM=
X-Received: by 2002:a81:ff12:0:b0:2db:2d8a:9769 with SMTP id
 k18-20020a81ff12000000b002db2d8a9769mr17305112ywn.172.1646834768695; Wed, 09
 Mar 2022 06:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20220309124132.291861-1-mkl@pengutronix.de> <20220309124132.291861-15-mkl@pengutronix.de>
In-Reply-To: <20220309124132.291861-15-mkl@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 9 Mar 2022 23:05:57 +0900
Message-ID: <CAMZ6Rq+R-yxYm4Kk+aoaQXNedKkmq0LbwDSxs0nXdJMn6t+=bw@mail.gmail.com>
Subject: Re: [can-next-rfc 14/21] can: gs_usb: use union and FLEX_ARRAY for
 data in struct gs_host_frame
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Peter Fink <pfink@christ-es.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 9 Mar 2022 =C3=A0 22:39, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> From: Peter Fink <pfink@christ-es.de>
>
> Modify struct gs_host_frame to make use of a union and
> DECLARE_FLEX_ARRAY to be able to store different data (lengths), which
> will be added in later commits.
>
> Store the gs_host_frame length in TX direction (host -> device) in
> struct gs_can::hf_size_tx and RX direction (device -> host) in struct
> gs_usb::hf_size_rx so it must be calculated only once.
>
> Signed-off-by: Peter Fink <pfink@christ-es.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/gs_usb.c | 37 +++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 4bc10264005b..1fe9d9f08c17 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -146,6 +146,10 @@ struct gs_device_bt_const {
>
>  #define GS_CAN_FLAG_OVERFLOW BIT(0)
>
> +struct classic_can {
> +       u8 data[8];
> +} __packed;
> +
>  struct gs_host_frame {
>         u32 echo_id;
>         __le32 can_id;
> @@ -155,7 +159,9 @@ struct gs_host_frame {
>         u8 flags;
>         u8 reserved;
>
> -       u8 data[8];
> +       union {
> +               DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
> +       };
>  } __packed;
>  /* The GS USB devices make use of the same flags and masks as in
>   * linux/can.h and linux/can/error.h, and no additional mapping is neces=
sary.
> @@ -187,6 +193,8 @@ struct gs_can {
>         struct can_bittiming_const bt_const;
>         unsigned int channel;   /* channel number */
>
> +       unsigned int hf_size_tx;
> +
>         /* This lock prevents a race condition between xmit and receive. =
*/
>         spinlock_t tx_ctx_lock;
>         struct gs_tx_context tx_context[GS_MAX_TX_URBS];
> @@ -200,6 +208,7 @@ struct gs_usb {
>         struct gs_can *canch[GS_MAX_INTF];
>         struct usb_anchor rx_submitted;
>         struct usb_device *udev;
> +       unsigned int hf_size_rx;
>         u8 active_channels;
>  };
>
> @@ -343,7 +352,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>                 cf->can_id =3D le32_to_cpu(hf->can_id);
>
>                 can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
> -               memcpy(cf->data, hf->data, 8);
> +               memcpy(cf->data, hf->classic_can->data, 8);
>
>                 /* ERROR frames tell us information about the controller =
*/
>                 if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
> @@ -398,7 +407,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>   resubmit_urb:
>         usb_fill_bulk_urb(urb, usbcan->udev,
>                           usb_rcvbulkpipe(usbcan->udev, GSUSB_ENDPOINT_IN=
),
> -                         hf, sizeof(struct gs_host_frame),
> +                         hf, dev->parent->hf_size_rx,
>                           gs_usb_receive_bulk_callback, usbcan);
>
>         rc =3D usb_submit_urb(urb, GFP_ATOMIC);
> @@ -485,7 +494,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *=
skb,
>         if (!urb)
>                 goto nomem_urb;
>
> -       hf =3D usb_alloc_coherent(dev->udev, sizeof(*hf), GFP_ATOMIC,
> +       hf =3D usb_alloc_coherent(dev->udev, dev->hf_size_tx, GFP_ATOMIC,
>                                 &urb->transfer_dma);
>         if (!hf) {
>                 netdev_err(netdev, "No memory left for USB buffer\n");
> @@ -509,11 +518,11 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff=
 *skb,
>         hf->can_id =3D cpu_to_le32(cf->can_id);
>         hf->can_dlc =3D can_get_cc_dlc(cf, dev->can.ctrlmode);
>
> -       memcpy(hf->data, cf->data, cf->len);
> +       memcpy(hf->classic_can->data, cf->data, cf->len);
>
>         usb_fill_bulk_urb(urb, dev->udev,
>                           usb_sndbulkpipe(dev->udev, GSUSB_ENDPOINT_OUT),
> -                         hf, sizeof(*hf),
> +                         hf, dev->hf_size_tx,
>                           gs_usb_xmit_callback, txc);
>
>         urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> @@ -531,8 +540,8 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *=
skb,
>                 gs_free_tx_context(txc);
>
>                 usb_unanchor_urb(urb);
> -               usb_free_coherent(dev->udev,
> -                                 sizeof(*hf), hf, urb->transfer_dma);
> +               usb_free_coherent(dev->udev, urb->transfer_buffer_length,
> +                                 urb->transfer_buffer, urb->transfer_dma=
);
>
>                 if (rc =3D=3D -ENODEV) {
>                         netif_device_detach(netdev);
> @@ -552,7 +561,8 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *=
skb,
>         return NETDEV_TX_OK;
>
>   badidx:
> -       usb_free_coherent(dev->udev, sizeof(*hf), hf, urb->transfer_dma);
> +       usb_free_coherent(dev->udev, urb->transfer_buffer_length,
> +                         urb->transfer_buffer, urb->transfer_dma);
>   nomem_hf:
>         usb_free_urb(urb);
>
> @@ -569,6 +579,7 @@ static int gs_can_open(struct net_device *netdev)
>         struct gs_usb *parent =3D dev->parent;
>         int rc, i;
>         struct gs_device_mode *dm;
> +       struct gs_host_frame *hf;
>         u32 ctrlmode;
>         u32 flags =3D 0;
>
> @@ -576,6 +587,8 @@ static int gs_can_open(struct net_device *netdev)
>         if (rc)
>                 return rc;
>
> +       dev->hf_size_tx =3D struct_size(hf, classic_can, 1);

struct_size(hf, classic_can, 1) is a constant value, isn't it?
Why not make this a macro?
Also, what is the purpose of the FLEX_ARRAY if it contains only one element=
?

I do not understand the logic. Sorry if I am wrong.

> +
>         if (!parent->active_channels) {
>                 for (i =3D 0; i < GS_MAX_RX_URBS; i++) {
>                         struct urb *urb;
> @@ -588,7 +601,7 @@ static int gs_can_open(struct net_device *netdev)
>
>                         /* alloc rx buffer */
>                         buf =3D usb_alloc_coherent(dev->udev,
> -                                                sizeof(struct gs_host_fr=
ame),
> +                                                dev->parent->hf_size_rx,
>                                                  GFP_KERNEL,
>                                                  &urb->transfer_dma);
>                         if (!buf) {
> @@ -604,7 +617,7 @@ static int gs_can_open(struct net_device *netdev)
>                                           usb_rcvbulkpipe(dev->udev,
>                                                           GSUSB_ENDPOINT_=
IN),
>                                           buf,
> -                                         sizeof(struct gs_host_frame),
> +                                         dev->parent->hf_size_rx,
>                                           gs_usb_receive_bulk_callback, p=
arent);
>                         urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
>
> @@ -886,6 +899,7 @@ static int gs_usb_probe(struct usb_interface *intf,
>                         const struct usb_device_id *id)
>  {
>         struct usb_device *udev =3D interface_to_usbdev(intf);
> +       struct gs_host_frame *hf;
>         struct gs_usb *dev;
>         int rc =3D -ENOMEM;
>         unsigned int icount, i;
> @@ -947,6 +961,7 @@ static int gs_usb_probe(struct usb_interface *intf,
>         }
>
>         init_usb_anchor(&dev->rx_submitted);
> +       dev->hf_size_rx =3D struct_size(hf, classic_can, 1);

Same comment as hf_size_tx.

>
>         usb_set_intfdata(intf, dev);
>         dev->udev =3D udev;
> --
> 2.34.1
>
>
