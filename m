Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218A15A2A36
	for <lists+linux-can@lfdr.de>; Fri, 26 Aug 2022 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiHZPA2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Aug 2022 11:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiHZPAT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Aug 2022 11:00:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ADD6FA2C
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 08:00:17 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oRaoh-0000KG-TC; Fri, 26 Aug 2022 17:00:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7932AD479B;
        Fri, 26 Aug 2022 15:00:13 +0000 (UTC)
Date:   Fri, 26 Aug 2022 17:00:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH 1/2] can: gs_usb: hardware timestamp support
Message-ID: <20220826150008.aztp74ig7uggf333@pengutronix.de>
References: <20220826104629.2837024-1-mkl@pengutronix.de>
 <20220826104629.2837024-2-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ohvb6euv5nkapazl"
Content-Disposition: inline
In-Reply-To: <20220826104629.2837024-2-mkl@pengutronix.de>
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


--ohvb6euv5nkapazl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.08.2022 12:46:28, Marc Kleine-Budde wrote:
> From: John Whittington <git@jbrengineering.co.uk>
>=20
> Adds support for hardware timestamps if the firmware includes it as a
> feature via the GS_CAN_FEATURE_HW_TIMESTAMP flag. Checks for this
> feature during probe, extends the RX expected length if it is and
> enables it during open.
>=20
> `classic_can_ts` and `canfd_ts` structs are copied and extended to
> include the us timestamp following data as defined in the firmware. The
> timestamp is then captured and set using `skb_hwtstamps` on each RX.
>=20
> The frame us timestamp is provided from a 32 bit 1 MHz timer which would
> roll over after 4294 seconds so a cyclecounter, timecounter and delayed
> worker are used to convert the timer into a proper ns timestamp - same
> implementation as efd8d98dfb900 ("can: mcp251xfd: add HW timestamp
> infrastructure").
>=20
> Hardware timestamps are added to capabilities as b1f6b93e678fb ("can:
> mcp251xfd: advertise timestamping capabilities")
>=20
> Signed-off-by: John Whittington <git@jbrengineering.co.uk>
> Link: https://github.com/candle-usb/candleLight_fw/issues/100
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Please compile the driver with C=3D1, i.e. "make C=3D1" and fix the
following errors:

| drivers/net/can/usb/gs_usb.c:438:6: warning: symbol 'gs_usb_timestamp_ini=
t' was not declared. Should it be static?
| drivers/net/can/usb/gs_usb.c:454:6: warning: symbol 'gs_usb_timestamp_sto=
p' was not declared. Should it be static?
| drivers/net/can/usb/gs_usb.c:539:64: warning: cast to restricted __le32
| drivers/net/can/usb/gs_usb.c:553:64: warning: cast to restricted __le32
| drivers/net/can/usb/gs_usb.c:1100:6: warning: symbol 'gs_usb_get_ts_info_=
hwts' was not declared. Should it be static?

> ---
>  drivers/net/can/usb/gs_usb.c | 142 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index baf749c8cda3..0d6729f12946 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -16,6 +16,9 @@
>  #include <linux/netdevice.h>
>  #include <linux/signal.h>
>  #include <linux/usb.h>
> +#include <linux/timecounter.h>
> +#include <linux/workqueue.h>
> +#include <linux/clocksource.h>

please keep includes sorted

> =20
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -37,6 +40,13 @@
>  #define GSUSB_ENDPOINT_IN 1
>  #define GSUSB_ENDPOINT_OUT 2
> =20
> +/* Timestamp 32 bit timer runs at 1 MHz (1 us tick). Worker accounts for=
 timer
> + * overflow (will be after ~71 minutes) */

Please move the closing */ to a new line.

> +#define GSUSB_TIMESTAMP_TIMER_HZ 1e6

1e6 is not an int and sparse will complain about it:

|   CHECK   drivers/net/can/usb/gs_usb.c                                   =
                                                                       =20
| drivers/net/can/usb/gs_usb.c:47:1: error: bad integer constant expression=
                                                                       =20
| drivers/net/can/usb/gs_usb.c:47:1: error: static assertion failed: "GSUSB=
_TIMESTAMP_WORK_DELAY_SEC < CYCLECOUNTER_MASK(32) / GSUSB_TIMESTAMP_TIMER_H=
Z / 2"

use:

#define GSUSB_TIMESTAMP_TIMER_HZ (1 * HZ_PER_MHZ)

instead and add "linux/units.h" to includes.

> +#define GSUSB_TIMESTAMP_WORK_DELAY_SEC 1800
> +static_assert(GSUSB_TIMESTAMP_WORK_DELAY_SEC <
> +	      CYCLECOUNTER_MASK(32) / GSUSB_TIMESTAMP_TIMER_HZ / 2);
> +
>  /* Device specific constants */
>  enum gs_usb_breq {
>  	GS_USB_BREQ_HOST_FORMAT =3D 0,
> @@ -199,6 +209,11 @@ struct classic_can {
>  	u8 data[8];
>  } __packed;
> =20
> +struct classic_can_ts {
> +	u8 data[8];
> +	u32 timestamp_us;

Make this __le32, that will fix the sparse warning, too.

> +} __packed;
> +
>  struct classic_can_quirk {
>  	u8 data[8];
>  	u8 quirk;
> @@ -208,6 +223,11 @@ struct canfd {
>  	u8 data[64];
>  } __packed;
> =20
> +struct canfd_ts {
> +	u8 data[64];
> +	u32 timestamp_us;

Make this __le32, that will fix the sparse warning, too.

> +} __packed;
> +
>  struct canfd_quirk {
>  	u8 data[64];
>  	u8 quirk;
> @@ -225,7 +245,9 @@ struct gs_host_frame {
>  	union {
>  		DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
>  		DECLARE_FLEX_ARRAY(struct classic_can_quirk, classic_can_quirk);
> +		DECLARE_FLEX_ARRAY(struct classic_can_ts, classic_can_ts);
>  		DECLARE_FLEX_ARRAY(struct canfd, canfd);
> +		DECLARE_FLEX_ARRAY(struct canfd_ts, canfd_ts);
>  		DECLARE_FLEX_ARRAY(struct canfd_quirk, canfd_quirk);

Please make the order uniform, make _ts 2nd and _quirk 3rd.

>  	};
>  } __packed;
> @@ -259,6 +281,11 @@ struct gs_can {
>  	struct can_bittiming_const bt_const, data_bt_const;
>  	unsigned int channel;	/* channel number */
> =20
> +	/* time counter for hardware timestamps */
> +	struct cyclecounter cc;
> +	struct timecounter tc;
> +	struct delayed_work timestamp;
> +
>  	u32 feature;
>  	unsigned int hf_size_tx;
> =20
> @@ -351,6 +378,83 @@ static int gs_cmd_reset(struct gs_can *gsdev)
>  	return rc;
>  }
> =20
> +static int gs_usb_get_sof_timestamp(struct net_device *netdev,
> +				    u32 *sof_timestamp_us)
> +{
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	int rc;
> +
> +	rc =3D usb_control_msg_recv(interface_to_usbdev(dev->iface),
> +			     usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
> +			     GS_USB_BREQ_TIMESTAMP,
> +			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> +			     dev->channel, 0,
> +			     sof_timestamp_us, sizeof(*sof_timestamp_us),
> +			     USB_CTRL_GET_TIMEOUT,
> +			     GFP_KERNEL);

CHECK: Alignment should match open parenthesis
#125: FILE: drivers/net/can/usb/gs_usb.c:390:
+       rc =3D usb_control_msg_recv(interface_to_usbdev(dev->iface),
+                            usb_sndctrlpipe(interface_to_usbdev(dev->iface=
), 0),

> +
> +	return (rc > 0) ? 0 : rc;

The doc says:

| Return: If successful, 0 is returned, Otherwise, a negative error number.

"return usb_control_msg_recv()" should be sufficient.

> +}
> +
> +static u64 gs_usb_timestamp_read(const struct cyclecounter *cc)
> +{
> +	const struct gs_can *dev;
> +	u32 timestamp =3D 0;
> +	int err;
> +
> +	dev =3D container_of(cc, struct gs_can, cc);
> +	err =3D gs_usb_get_sof_timestamp(dev->netdev, &timestamp);
> +	if (err)
> +		netdev_err(dev->netdev,
> +			   "Error %d while reading timestamp. HW timestamps may be inaccurate=
=2E",
> +			   err);
> +
> +	return timestamp;
> +}
> +
> +static void gs_usb_set_timestamp(struct gs_can *dev,
> +				 struct sk_buff *skb, u32 timestamp)
> +{
> +	struct skb_shared_hwtstamps *hwtstamps =3D skb_hwtstamps(skb);
> +	u64 ns;
> +
> +	ns =3D timecounter_cyc2time(&dev->tc, timestamp);
> +	hwtstamps->hwtstamp =3D ns_to_ktime(ns);
> +}
> +
> +static void gs_usb_timestamp_work(struct work_struct *work)
> +{
> +	struct delayed_work *delayed_work =3D to_delayed_work(work);
> +	struct gs_can *dev;
> +
> +	dev =3D container_of(delayed_work, struct gs_can, timestamp);
> +	timecounter_read(&dev->tc);
> +
> +	schedule_delayed_work(&dev->timestamp,
> +			      GSUSB_TIMESTAMP_WORK_DELAY_SEC * HZ);
> +}
> +
> +void gs_usb_timestamp_init(struct gs_can *dev)

static

> +{
> +	struct cyclecounter *cc =3D &dev->cc;
> +
> +	cc->read =3D gs_usb_timestamp_read;
> +	cc->mask =3D CYCLECOUNTER_MASK(32);
> +	cc->shift =3D 1;
> +	cc->mult =3D clocksource_hz2mult(GSUSB_TIMESTAMP_TIMER_HZ, cc->shift);
> +
> +	timecounter_init(&dev->tc, &dev->cc, ktime_get_real_ns());
> +
> +	INIT_DELAYED_WORK(&dev->timestamp, gs_usb_timestamp_work);
> +	schedule_delayed_work(&dev->timestamp,
> +			      GSUSB_TIMESTAMP_WORK_DELAY_SEC * HZ);
> +}
> +
> +void gs_usb_timestamp_stop(struct gs_can *dev)

static

> +{
> +	cancel_delayed_work_sync(&dev->timestamp);
> +}
> +
>  static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
>  {
>  	struct can_device_stats *can_stats =3D &dev->can.can_stats;
> @@ -428,6 +532,11 @@ static void gs_usb_receive_bulk_callback(struct urb =
*urb)
>  				cfd->flags |=3D CANFD_ESI;
> =20
>  			memcpy(cfd->data, hf->canfd->data, cfd->len);
> +
> +			/* set hardware timestamp if supported */
> +			if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
> +				gs_usb_set_timestamp(dev, skb, le32_to_cpu(hf->canfd_ts->timestamp_u=
s));
> +			}

braces {} are not necessary for single statement blocks

>  		} else {
>  			skb =3D alloc_can_skb(dev->netdev, &cf);
>  			if (!skb)
> @@ -438,6 +547,11 @@ static void gs_usb_receive_bulk_callback(struct urb =
*urb)
> =20
>  			memcpy(cf->data, hf->classic_can->data, 8);
> =20
> +			/* set hardware timestamp if supported */
> +			if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
> +				gs_usb_set_timestamp(dev, skb, le32_to_cpu(hf->classic_can_ts->times=
tamp_us));
> +			}
> +

braces {} are not necessary for single statement blocks

>  			/* ERROR frames tell us information about the controller */
>  			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
>  				gs_update_state(dev, cf);
> @@ -814,6 +928,10 @@ static int gs_can_open(struct net_device *netdev)
>  	else if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
>  		flags |=3D GS_CAN_MODE_LISTEN_ONLY;
> =20
> +	/* if hardware supports timestamps, enable it */
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +		flags |=3D GS_CAN_MODE_HW_TIMESTAMP;
> +
>  	/* Controller is not allowed to retry TX
>  	 * this mode is unavailable on atmels uc3c hardware
>  	 */
> @@ -838,6 +956,10 @@ static int gs_can_open(struct net_device *netdev)
>  		return rc;
>  	}
> =20
> +	/* start polling sof timestamp */
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +		gs_usb_timestamp_init(dev);
> +
>  	kfree(dm);
> =20
>  	dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> @@ -869,6 +991,10 @@ static int gs_can_close(struct net_device *netdev)
>  					  dev->rxbuf_dma[i]);
>  	}
> =20
> +	/* Stop polling sof timestamp */
> +	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +		gs_usb_timestamp_stop(dev);
> +
>  	/* Stop sending URBs */
>  	usb_kill_anchored_urbs(&dev->tx_submitted);
>  	atomic_set(&dev->active_tx_urbs, 0);
> @@ -895,6 +1021,7 @@ static const struct net_device_ops gs_usb_netdev_ops=
 =3D {
>  	.ndo_stop =3D gs_can_close,
>  	.ndo_start_xmit =3D gs_can_start_xmit,
>  	.ndo_change_mtu =3D can_change_mtu,
> +	.ndo_eth_ioctl =3D can_eth_ioctl_hwts,
>  };
> =20
>  static int gs_usb_set_identify(struct net_device *netdev, bool do_identi=
fy)
> @@ -946,7 +1073,7 @@ static int gs_usb_set_phys_id(struct net_device *dev,
> =20
>  static const struct ethtool_ops gs_usb_ethtool_ops =3D {
>  	.set_phys_id =3D gs_usb_set_phys_id,
> -	.get_ts_info =3D ethtool_op_get_ts_info,
> +	.get_ts_info =3D can_ethtool_op_get_ts_info_hwts,
>  };
> =20
>  static struct gs_can *gs_make_candev(unsigned int channel,
> @@ -1228,8 +1355,17 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		}
>  		dev->canch[i]->parent =3D dev;
> =20
> -		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD)
> -			dev->hf_size_rx =3D struct_size(hf, canfd, 1);
> +		/* set rx packet size based on FD and if hardware timestamps are
> +		 * supported.
> +		 */
> +		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
> +			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +				dev->hf_size_rx =3D struct_size(hf, canfd_ts, 1);
> +			else
> +				dev->hf_size_rx =3D struct_size(hf, canfd, 1);
> +		} else if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
> +			dev->hf_size_rx =3D struct_size(hf, classic_can_ts, 1);
> +		}

There are several gs_usb compatible firmware implementations out there,
we cannot test them all. Better use max(), to get the true maximum
needed USB rx len.

>  	}
> =20
>  	kfree(dconf);

I'll fix all these and send a v2.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ohvb6euv5nkapazl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMI3/UACgkQrX5LkNig
012rdQf9FzHDhbHzGvJMFA3peLsUX73pcVzD0wnquR/W6EjrUSWBy8yp/yYcRnz4
HBA5MWhZOyQRM8PLpIPHdfMaX9mT1V2T9ieph5xDZbD1dEQ8ZWjfrg5ofGY/Tsc4
tfJbOHKggi+JPCwolXOqIoiYlb51rDIrZDp6eKtZkSEeT5sKdOHj6zo2UANGSRQ9
dBrxYW2n2tKFDuimxp9m0bb4ZwwN3svUnQKyUIcEwFv4EfSwaqef03sfjoS6KUkp
nE9hdGcUdFmRD96pxIiPMBnCk43cxphnuGcvecW2Hl3Cir8JD/8FI3FGxX44FuQU
AyfK2ZX9dycTYzk87NL8FWX21akllg==
=ikCO
-----END PGP SIGNATURE-----

--ohvb6euv5nkapazl--
