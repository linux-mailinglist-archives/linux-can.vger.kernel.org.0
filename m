Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCBE57A754
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 21:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiGSTj1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 15:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiGSTjZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 15:39:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BDC45040
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 12:39:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDt3y-0006I0-7r; Tue, 19 Jul 2022 21:39:22 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7E8F5B44C9;
        Tue, 19 Jul 2022 19:39:20 +0000 (UTC)
Date:   Tue, 19 Jul 2022 21:39:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 3/3] can: peak_usb: Includes support for a new MCU
Message-ID: <20220719193919.nad3xa4zlxldajd2@pengutronix.de>
References: <20220719120632.26774-1-s.grosjean@peak-system.com>
 <20220719120632.26774-3-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ykb7q3vh5p7akpjq"
Content-Disposition: inline
In-Reply-To: <20220719120632.26774-3-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ykb7q3vh5p7akpjq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2022 14:06:32, Stephane Grosjean wrote:
> The CANFD-USB PCAN-USB FD interface undergoes an internal component change
> that requires a slight modification of its drivers, which leads them to
> dynamically use endpoint numbers provided by the interface itself.
> In addition to a change in the calls to the USB functions exported by the
> kernel, the detection of the USB interface dedicated to CAN must also be
> modified, as some PEAK-System devices support other interfaces than CAN.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 70 ++++++++++++++++++----
>  1 file changed, 60 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 65487ec33566..267a70d3a5d1 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
[...]
> @@ -910,6 +941,14 @@ static int pcan_usb_fd_init(struct peak_usb_device *=
dev)
>  			dev->can.ctrlmode |=3D CAN_CTRLMODE_FD_NON_ISO;
>  		}
> =20
> +		/* if vendor rsp is of type 2, then it contains EP numbers to
> +		 * use for cmds pipes. If not, then default EP should be used.
> +		 */
> +		if (fw_info->type !=3D PCAN_USBFD_TYPE_EXT) {

This and the other type comparison throws the following warning:

  CHECK   /srv/work/frogger/socketcan/linux/drivers/net/can/usb/peak_usb/pc=
an_usb_fd.c                                                                =
                                         =20
drivers/net/can/usb/peak_usb/pcan_usb_fd.c:945:28: warning: restricted __le=
16 degrades to integer                                                     =
       =20
drivers/net/can/usb/peak_usb/pcan_usb_fd.c:982:20: warning: restricted __le=
16 degrades to integer=20

I've fixed them with this incremental patch:

-               if (fw_info->type !=3D PCAN_USBFD_TYPE_EXT) {
+               if (fw_info->type !=3D cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {

> +			fw_info->cmd_out_ep =3D PCAN_USBPRO_EP_CMDOUT;
> +			fw_info->cmd_in_ep =3D PCAN_USBPRO_EP_CMDIN;
> +		}
> +
>  		/* tell the hardware the can driver is running */
>  		err =3D pcan_usb_fd_drv_loaded(dev, 1);
>  		if (err) {
> @@ -930,12 +969,23 @@ static int pcan_usb_fd_init(struct peak_usb_device =
*dev)
>  		/* do a copy of the ctrlmode[_supported] too */
>  		dev->can.ctrlmode =3D ppdev->dev.can.ctrlmode;
>  		dev->can.ctrlmode_supported =3D ppdev->dev.can.ctrlmode_supported;
> +
> +		fw_info =3D &pdev->usb_if->fw_info;
>  	}
> =20
>  	pdev->usb_if->dev[dev->ctrl_idx] =3D dev;
>  	dev->device_number =3D
>  		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
> =20
> +	/* if vendor rsp is of type 2, then it contains EP numbers to
> +	 * use for data pipes. If not, then statically defined EP are used
> +	 * (see peak_usb_create_dev()).
> +	 */
> +	if (fw_info->type =3D=3D PCAN_USBFD_TYPE_EXT) {
> +		dev->ep_msg_in =3D fw_info->data_in_ep;
> +		dev->ep_msg_out =3D fw_info->data_out_ep[dev->ctrl_idx];
> +	}

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ykb7q3vh5p7akpjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLXCGUACgkQrX5LkNig
011Y/Qf/edgOMB3FrSFDRhlebWBgPgtuERyMnGiCDhkMCaiaV9z6a6/K1hFjfhR9
y7uny5Na7WseWNWiB9piVVhmAR0LY+LrTzQrng+0eOOhsNr1YCxYaw6bfROQJrQR
cpF+1JMpJbJMNqAmOQZSn/PnlyUY4M6p2Imms88b4nlhr9dUo22gnBhwwT1azOSK
+j7S4WOkIFmXI+jdukCp6F+1EPGza693+d1wO8vkX6kaoIrnz3PbjRvD31hLR/VH
T9APfvkmcKEsds2sXmaQp42dLvceKiDOUoVuTswR6KbTjKwtHSbMlFw1yYS1+fE4
LxATv3uwDAMovgGqTnsKXffk6gR+0Q==
=xn/2
-----END PGP SIGNATURE-----

--ykb7q3vh5p7akpjq--
