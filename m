Return-Path: <linux-can+bounces-2825-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A872EA393DC
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 08:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AA816ECC9
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 07:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53201B983E;
	Tue, 18 Feb 2025 07:37:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28691B87CE
	for <linux-can@vger.kernel.org>; Tue, 18 Feb 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864263; cv=none; b=kDFSZ7z1JI20i17Fw8x1TDFpHSXQ0jcx9KrWeKNDdEYSUpqbfQuyeqr7zJiGk/G9FrVkA4l5m6+y3YXUcce1fiYK/wH9oJArpRRGcY0kPoJZo5q8UycW+aNLElPj2/8VMoexaRCUEIsGaIsr24DdphoKdkzXeYWkc6suPAOSftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864263; c=relaxed/simple;
	bh=DUoJQlVlnERLhUSNoTxyxiAkOJwMamJa+WF47ELS5bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6Q+UUJBdtL4LXc6bx95E6++W/RskKA5wd6RddQot9vT2+g1o/vhIzEcugO1nLDgS0m8lpLe8Ym3xBiN3q7+YIxZJ6icFqRzM0W633qOpa5HzGJAoTN09O7FAENntYdDh3TP1ByI78FlBsytkfBh/0wfhHMT+QX/aQKMpraoqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkIAe-0006zz-Cf; Tue, 18 Feb 2025 08:37:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkIAd-001Y2U-2P;
	Tue, 18 Feb 2025 08:37:31 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5FA283C56E7;
	Tue, 18 Feb 2025 07:37:31 +0000 (UTC)
Date: Tue, 18 Feb 2025 08:37:30 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Matt Jan <zoo868e@gmail.com>, 
	syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: ucan: Correct the size parameter
Message-ID: <20250218-accurate-viridian-manatee-6f2878-mkl@pengutronix.de>
References: <67b323a4.050a0220.173698.002b.GAE@google.com>
 <20250217190404.354574-1-zoo868e@gmail.com>
 <2f33170a-f7bb-47dd-8cb7-15c055dabc83@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4vmx37zg34x3jwu"
Content-Disposition: inline
In-Reply-To: <2f33170a-f7bb-47dd-8cb7-15c055dabc83@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--h4vmx37zg34x3jwu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: ucan: Correct the size parameter
MIME-Version: 1.0

On 18.02.2025 11:22:11, Vincent Mailhol wrote:
> On 18/02/2025 at 04:04, Matt Jan wrote:
> > According to the comment, the size parameter is only required when
> > @dst is not an array, or when the copy needs to be smaller than
> > sizeof(@dst). Since the source is a `union ucan_ctl_payload`, the
> > correct size should be sizeof(union ucan_ctl_payload).
>=20
> While this fix is correct, I think that the root cause is that
> up->ctl_msg_buffer->raw is not NUL terminated.
>=20
> Because of that, a local copy was added, just to reintroduce the NUL
> terminating byte.
>=20
> I think it is better to just directly terminate up->ctl_msg_buffer->raw
> and get rid of the firmware_str local variable and the string copy.
>=20
> So, what about this:
>=20
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> index 39a63b7313a4..268085453d24 100644
> --- a/drivers/net/can/usb/ucan.c
> +++ b/drivers/net/can/usb/ucan.c
> @@ -186,7 +186,7 @@ union ucan_ctl_payload {
>          */
>         struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;
>=20
> -       u8 raw[128];
> +       char fw_info[128];
>  } __packed;
>=20
>  enum {
> @@ -424,18 +424,19 @@ static int ucan_ctrl_command_out(struct ucan_priv *=
up,
>                                UCAN_USB_CTL_PIPE_TIMEOUT);
>  }
>=20
> -static int ucan_device_request_in(struct ucan_priv *up,
> -                                 u8 cmd, u16 subcmd, u16 datalen)
> +static void ucan_get_fw_info(struct ucan_priv *up, char *fw_info,
> size_t size)
>  {
> -       return usb_control_msg(up->udev,
> -                              usb_rcvctrlpipe(up->udev, 0),
> -                              cmd,
> -                              USB_DIR_IN | USB_TYPE_VENDOR |
> USB_RECIP_DEVICE,
> -                              subcmd,
> -                              0,
> -                              up->ctl_msg_buffer,
> -                              datalen,
> -                              UCAN_USB_CTL_PIPE_TIMEOUT);
> +       int ret;
> +
> +       ret =3D usb_control_msg(up->udev, usb_rcvctrlpipe(up->udev, 0),
> +                             UCAN_DEVICE_GET_FW_STRING,
> +                             USB_DIR_IN | USB_TYPE_VENDOR |
> USB_RECIP_DEVICE,
> +                             0, 0, fw_info, size - 1,
> +                             UCAN_USB_CTL_PIPE_TIMEOUT);
> +       if (ret > 0)
> +               fw_info[ret] =3D '\0';
> +       else
> +               strcpy(fw_info, "unknown");
>  }
>=20
>  /* Parse the device information structure reported by the device and
> @@ -1314,7 +1315,6 @@ static int ucan_probe(struct usb_interface *intf,
>         u8 in_ep_addr;
>         u8 out_ep_addr;
>         union ucan_ctl_payload *ctl_msg_buffer;
> -       char firmware_str[sizeof(union ucan_ctl_payload) + 1];
>=20
>         udev =3D interface_to_usbdev(intf);
>=20
> @@ -1527,17 +1527,6 @@ static int ucan_probe(struct usb_interface *intf,
>          */
>         ucan_parse_device_info(up, &ctl_msg_buffer->cmd_get_device_info);
>=20
> -       /* just print some device information - if available */
> -       ret =3D ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
> -                                    sizeof(union ucan_ctl_payload));
> -       if (ret > 0) {
> -               /* copy string while ensuring zero termination */
> -               strscpy(firmware_str, up->ctl_msg_buffer->raw,
> -                       sizeof(union ucan_ctl_payload) + 1);
> -       } else {
> -               strcpy(firmware_str, "unknown");
> -       }
> -
>         /* device is compatible, reset it */
>         ret =3D ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
>         if (ret < 0)
> @@ -1555,7 +1544,10 @@ static int ucan_probe(struct usb_interface *intf,
>=20
>         /* initialisation complete, log device info */
>         netdev_info(up->netdev, "registered device\n");
> -       netdev_info(up->netdev, "firmware string: %s\n", firmware_str);
> +       ucan_get_fw_info(up, up->ctl_msg_buffer->fw_info,
> +                        sizeof(up->ctl_msg_buffer->fw_info));
> +       netdev_info(up->netdev, "firmware string: %s\n",
> +                   up->ctl_msg_buffer->fw_info);

We could also use the:

    printf("%.*s", sizeof(up->ctl_msg_buffer->fw_info), up->ctl_msg_buffer-=
>fw_info);

format string trick to only print a limited number of chars of the given
string. But I'm also fine with your solution. Either way, please send a
proper patch :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h4vmx37zg34x3jwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme0OLUACgkQDHRl3/mQ
kZw9uwgAmpOyOf1wkR0AGLIlgvqr34+Zhb618ewFvznR16Bn0/6VoNBDGUlQFzYA
0oS7rdFuA+Zv8DdfWg98kUyNiZ9E+2cIkqTioUAqzZVHgeFeD8aZrwxJa13tYkoi
0xHizIC58c5u6jdOcBvNagyt73qX0wYtEiUhEcGJiRl8BP2mApjv69rmdHkE76pA
hvld1rwWUYI1MB2nip8YRxYhpt4YCQfIX9VDcmIX6W76JJJGN2efLwoCGChmMyXA
Vac3DjnvluwxFcLP1JlbdlYUusrqRwK8ruzKHP2gpkqDCdL278RBV2+Mq9TXgGWH
SW+l/BA8hcxXzRJAUeDrYAzBa/+73Q==
=01QG
-----END PGP SIGNATURE-----

--h4vmx37zg34x3jwu--

