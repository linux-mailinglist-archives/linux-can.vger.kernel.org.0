Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB53D4D30E9
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 15:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiCIOTe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 09:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiCIOTe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 09:19:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051202F034
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 06:18:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRx95-0006RH-16; Wed, 09 Mar 2022 15:18:31 +0100
Received: from pengutronix.de (unknown [IPv6:2a02:908:393:af61:11a6:6968:f87e:ee79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C782F46D78;
        Wed,  9 Mar 2022 14:18:29 +0000 (UTC)
Date:   Wed, 9 Mar 2022 15:18:29 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Peter Fink <pfink@christ-es.de>
Subject: Re: [can-next-rfc 14/21] can: gs_usb: use union and FLEX_ARRAY for
 data in struct gs_host_frame
Message-ID: <20220309141829.33glce2cy4ylvzzg@pengutronix.de>
References: <20220309124132.291861-1-mkl@pengutronix.de>
 <20220309124132.291861-15-mkl@pengutronix.de>
 <CAMZ6Rq+R-yxYm4Kk+aoaQXNedKkmq0LbwDSxs0nXdJMn6t+=bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ponxsnp5kyjst2bp"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+R-yxYm4Kk+aoaQXNedKkmq0LbwDSxs0nXdJMn6t+=bw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ponxsnp5kyjst2bp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2022 23:05:57, Vincent Mailhol wrote:
> On Wed. 9 Mar 2022 =C3=A0 22:39, Marc Kleine-Budde <mkl@pengutronix.de> w=
rote:
> > From: Peter Fink <pfink@christ-es.de>
> >
> > Modify struct gs_host_frame to make use of a union and
> > DECLARE_FLEX_ARRAY to be able to store different data (lengths), which
> > will be added in later commits.
> >
> > Store the gs_host_frame length in TX direction (host -> device) in
> > struct gs_can::hf_size_tx and RX direction (device -> host) in struct
> > gs_usb::hf_size_rx so it must be calculated only once.
> >
> > Signed-off-by: Peter Fink <pfink@christ-es.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/can/usb/gs_usb.c | 37 +++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index 4bc10264005b..1fe9d9f08c17 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -146,6 +146,10 @@ struct gs_device_bt_const {
> >
> >  #define GS_CAN_FLAG_OVERFLOW BIT(0)
> >
> > +struct classic_can {
> > +       u8 data[8];
> > +} __packed;
> > +
> >  struct gs_host_frame {
> >         u32 echo_id;
> >         __le32 can_id;
> > @@ -155,7 +159,9 @@ struct gs_host_frame {
> >         u8 flags;
> >         u8 reserved;
> >
> > -       u8 data[8];
> > +       union {
> > +               DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
> > +       };
> >  } __packed;
> >  /* The GS USB devices make use of the same flags and masks as in
> >   * linux/can.h and linux/can/error.h, and no additional mapping is nec=
essary.
> > @@ -187,6 +193,8 @@ struct gs_can {
> >         struct can_bittiming_const bt_const;
> >         unsigned int channel;   /* channel number */
> >
> > +       unsigned int hf_size_tx;
> > +
> >         /* This lock prevents a race condition between xmit and receive=
=2E */
> >         spinlock_t tx_ctx_lock;
> >         struct gs_tx_context tx_context[GS_MAX_TX_URBS];
> > @@ -200,6 +208,7 @@ struct gs_usb {
> >         struct gs_can *canch[GS_MAX_INTF];
> >         struct usb_anchor rx_submitted;
> >         struct usb_device *udev;
> > +       unsigned int hf_size_rx;
> >         u8 active_channels;
> >  };
> >
> > @@ -343,7 +352,7 @@ static void gs_usb_receive_bulk_callback(struct urb=
 *urb)
> >                 cf->can_id =3D le32_to_cpu(hf->can_id);
> >
> >                 can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode=
);
> > -               memcpy(cf->data, hf->data, 8);
> > +               memcpy(cf->data, hf->classic_can->data, 8);
> >
> >                 /* ERROR frames tell us information about the controlle=
r */
> >                 if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
> > @@ -398,7 +407,7 @@ static void gs_usb_receive_bulk_callback(struct urb=
 *urb)
> >   resubmit_urb:
> >         usb_fill_bulk_urb(urb, usbcan->udev,
> >                           usb_rcvbulkpipe(usbcan->udev, GSUSB_ENDPOINT_=
IN),
> > -                         hf, sizeof(struct gs_host_frame),
> > +                         hf, dev->parent->hf_size_rx,
> >                           gs_usb_receive_bulk_callback, usbcan);
> >
> >         rc =3D usb_submit_urb(urb, GFP_ATOMIC);
> > @@ -485,7 +494,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff=
 *skb,
> >         if (!urb)
> >                 goto nomem_urb;
> >
> > -       hf =3D usb_alloc_coherent(dev->udev, sizeof(*hf), GFP_ATOMIC,
> > +       hf =3D usb_alloc_coherent(dev->udev, dev->hf_size_tx, GFP_ATOMI=
C,
> >                                 &urb->transfer_dma);
> >         if (!hf) {
> >                 netdev_err(netdev, "No memory left for USB buffer\n");
> > @@ -509,11 +518,11 @@ static netdev_tx_t gs_can_start_xmit(struct sk_bu=
ff *skb,
> >         hf->can_id =3D cpu_to_le32(cf->can_id);
> >         hf->can_dlc =3D can_get_cc_dlc(cf, dev->can.ctrlmode);
> >
> > -       memcpy(hf->data, cf->data, cf->len);
> > +       memcpy(hf->classic_can->data, cf->data, cf->len);
> >
> >         usb_fill_bulk_urb(urb, dev->udev,
> >                           usb_sndbulkpipe(dev->udev, GSUSB_ENDPOINT_OUT=
),
> > -                         hf, sizeof(*hf),
> > +                         hf, dev->hf_size_tx,
> >                           gs_usb_xmit_callback, txc);
> >
> >         urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> > @@ -531,8 +540,8 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff=
 *skb,
> >                 gs_free_tx_context(txc);
> >
> >                 usb_unanchor_urb(urb);
> > -               usb_free_coherent(dev->udev,
> > -                                 sizeof(*hf), hf, urb->transfer_dma);
> > +               usb_free_coherent(dev->udev, urb->transfer_buffer_lengt=
h,
> > +                                 urb->transfer_buffer, urb->transfer_d=
ma);
> >
> >                 if (rc =3D=3D -ENODEV) {
> >                         netif_device_detach(netdev);
> > @@ -552,7 +561,8 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff=
 *skb,
> >         return NETDEV_TX_OK;
> >
> >   badidx:
> > -       usb_free_coherent(dev->udev, sizeof(*hf), hf, urb->transfer_dma=
);
> > +       usb_free_coherent(dev->udev, urb->transfer_buffer_length,
> > +                         urb->transfer_buffer, urb->transfer_dma);
> >   nomem_hf:
> >         usb_free_urb(urb);
> >
> > @@ -569,6 +579,7 @@ static int gs_can_open(struct net_device *netdev)
> >         struct gs_usb *parent =3D dev->parent;
> >         int rc, i;
> >         struct gs_device_mode *dm;
> > +       struct gs_host_frame *hf;
> >         u32 ctrlmode;
> >         u32 flags =3D 0;
> >
> > @@ -576,6 +587,8 @@ static int gs_can_open(struct net_device *netdev)
> >         if (rc)
> >                 return rc;
> >
> > +       dev->hf_size_tx =3D struct_size(hf, classic_can, 1);
>=20
> struct_size(hf, classic_can, 1) is a constant value, isn't it?

ACK

> Why not make this a macro?

It will not be constant with the addition of CAN-FD and the quirks
needed for some CAN devices.

> Also, what is the purpose of the FLEX_ARRAY if it contains only one eleme=
nt?

More will be added.

> I do not understand the logic. Sorry if I am wrong.

Granted, this patch without context looks a bit strange. Can we update
the patch description to make this easier to understand?

> > Modify struct gs_host_frame to make use of a union and
> > DECLARE_FLEX_ARRAY to be able to store different data (lengths), which
> > will be added in later commits.

> > +
> >         if (!parent->active_channels) {
> >                 for (i =3D 0; i < GS_MAX_RX_URBS; i++) {
> >                         struct urb *urb;
> > @@ -588,7 +601,7 @@ static int gs_can_open(struct net_device *netdev)
> >
> >                         /* alloc rx buffer */
> >                         buf =3D usb_alloc_coherent(dev->udev,
> > -                                                sizeof(struct gs_host_=
frame),
> > +                                                dev->parent->hf_size_r=
x,
> >                                                  GFP_KERNEL,
> >                                                  &urb->transfer_dma);
> >                         if (!buf) {
> > @@ -604,7 +617,7 @@ static int gs_can_open(struct net_device *netdev)
> >                                           usb_rcvbulkpipe(dev->udev,
> >                                                           GSUSB_ENDPOIN=
T_IN),
> >                                           buf,
> > -                                         sizeof(struct gs_host_frame),
> > +                                         dev->parent->hf_size_rx,
> >                                           gs_usb_receive_bulk_callback,=
 parent);
> >                         urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MA=
P;
> >
> > @@ -886,6 +899,7 @@ static int gs_usb_probe(struct usb_interface *intf,
> >                         const struct usb_device_id *id)
> >  {
> >         struct usb_device *udev =3D interface_to_usbdev(intf);
> > +       struct gs_host_frame *hf;
> >         struct gs_usb *dev;
> >         int rc =3D -ENOMEM;
> >         unsigned int icount, i;
> > @@ -947,6 +961,7 @@ static int gs_usb_probe(struct usb_interface *intf,
> >         }
> >
> >         init_usb_anchor(&dev->rx_submitted);
> > +       dev->hf_size_rx =3D struct_size(hf, classic_can, 1);
>=20
> Same comment as hf_size_tx.

ACK, in a later patch they will be different. For TX we use the size
corresponding to the selected CAN mode (CAN-2.0 or CAN-FD) of the CAN
interface. For the RX direction we have to use CAN-FD if a at least one
CAN interface of the USB device uses CAN-FD.

The TX size is per CAN interface, the RX size if per USB device (which
can consist of several CAN interfaces).

Many thanks for the deep review, otherwise you wouldn't have found this!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ponxsnp5kyjst2bp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIotzIACgkQrX5LkNig
010sVAf8ClYD4Tg1+tOwt2OunmiZrJAFwp9P2H4sOaKFT1m1H7O9L7w+hDfPlIMX
QEUETLqaID4Bh/pZPNZIJ3M2OAbkl1UwRy7EcE7qd4F3PvTLRHRbaPgHmncFQkwl
Fw/f3ZhHgsCh6kL541gVRBwOR+C+0W7oq5CPOb7BmvigijP3S/jOml3WLgMVIbAr
eqlF3npaTb5gubb0AvKrz0oKwyHUbrDsdW8iYMsoMiKORb7Kfe6g2t8BxRwq8gox
Y9d29DbGJPmPuxNeNAP0A1Gn3cVP132XYfJAq59/gJAShvy0eX9PGxT3OVTZTp2x
V9fPwjOvtlA489VV0Xy/QtkJyJ88cw==
=wsXA
-----END PGP SIGNATURE-----

--ponxsnp5kyjst2bp--
