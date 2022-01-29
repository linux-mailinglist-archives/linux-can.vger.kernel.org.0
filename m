Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836684A2FD8
	for <lists+linux-can@lfdr.de>; Sat, 29 Jan 2022 14:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiA2Nsr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 29 Jan 2022 08:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiA2Nsq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 29 Jan 2022 08:48:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D25C061714
        for <linux-can@vger.kernel.org>; Sat, 29 Jan 2022 05:48:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nDo5p-0000jy-Ue; Sat, 29 Jan 2022 14:48:42 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E3D7F26591;
        Sat, 29 Jan 2022 13:48:39 +0000 (UTC)
Date:   Sat, 29 Jan 2022 14:48:32 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/6] can: peak_usb: add callback to read user value of
 CANFD devices
Message-ID: <20220129134832.ig44ibvgcokj6g77@pengutronix.de>
References: <20220128150157.1222850-1-s.grosjean@peak-system.com>
 <20220128150157.1222850-3-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rxgtfox6awwjgufs"
Content-Disposition: inline
In-Reply-To: <20220128150157.1222850-3-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--rxgtfox6awwjgufs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.01.2022 16:01:53, Stephane Grosjean wrote:
> This patch adds the specific function that allows to read a user defined
> value from the non volatile memory of the USB CANFD interfaces of
> PEAK-System.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 65487ec33566..ab1a8b797ece 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -420,6 +420,24 @@ static int pcan_usb_fd_set_bittiming_fast(struct pea=
k_usb_device *dev,
>  	return pcan_usb_fd_send_cmd(dev, ++cmd);
>  }
> =20
> +/* read user device id from device */
> +static int pcan_usb_fd_get_user_devid(struct peak_usb_device *dev,
> +				      u32 *device_id)
> +{
> +	struct pcan_usb_fd_device *pdev =3D
> +		container_of(dev, struct pcan_usb_fd_device, dev);
> +	struct pcan_ufd_fw_info *fw_info =3D &pdev->usb_if->fw_info;
> +	int err;
> +
> +	err =3D pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
> +				    PCAN_USBPRO_INFO_FW,
> +				    fw_info, sizeof(*fw_info));
> +	if (!err)
> +		*device_id =3D le32_to_cpu(fw_info->dev_id[dev->ctrl_idx]);

Nitpick: please use the more common return on error:

        if (err)
                return err;

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rxgtfox6awwjgufs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmH1Ra0ACgkQqclaivrt
76lyVgf8CEUJaQ8rh5L0Jv9T9KjXbqVljh7dKk1W46ibgrfJFmP8r0y+VrgdHeIc
3NR9YEnuHH2ULU9cF5A+qkkO9QfyMJmOxZ4zqmWVyBikYWX0n/+vJykU4TS+Epx9
16dNZ2imhnqeEZLBVF2eVCWEe0E0sljLcSiDZkAAgU0+u8oXpe2ylX35u9KpKpHv
xSz333Y6zLjfHh+Bpl4UoQQImabr2TqUqYBVqqF4yz5gcJCJbG+GCAqsUI7v4ti0
mDv8cRk2tkgPEb8xcsYHHr7aEGod2K6+PA3V3H1uAp9NIUDe59CtDxUz8/L33SVE
Dw8tyu/gwPseyKTc3lsUA9DY0naiPA==
=2+Ul
-----END PGP SIGNATURE-----

--rxgtfox6awwjgufs--
