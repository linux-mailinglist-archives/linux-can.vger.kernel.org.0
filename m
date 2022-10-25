Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A7A60C628
	for <lists+linux-can@lfdr.de>; Tue, 25 Oct 2022 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJYIQe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Oct 2022 04:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJYIQc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Oct 2022 04:16:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A963295AD2
        for <linux-can@vger.kernel.org>; Tue, 25 Oct 2022 01:16:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onF6e-0006vj-FP; Tue, 25 Oct 2022 10:16:16 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B360810935C;
        Tue, 25 Oct 2022 08:16:13 +0000 (UTC)
Date:   Tue, 25 Oct 2022 10:16:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vivek Yadav <vivek.2311@samsung.com>
Cc:     rcsekar@samsung.com, wg@grandegger.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        alim.akhtar@samsung.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] can: m_can: Add ECC functionality for message RAM
Message-ID: <20221025081610.h6bjg6nuqdhkupvg@pengutronix.de>
References: <20221021095833.62406-1-vivek.2311@samsung.com>
 <CGME20221021102639epcas5p2241192d3ac873d1262372eeae948b401@epcas5p2.samsung.com>
 <20221021095833.62406-7-vivek.2311@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="244jhurzphrta6mf"
Content-Disposition: inline
In-Reply-To: <20221021095833.62406-7-vivek.2311@samsung.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--244jhurzphrta6mf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.10.2022 15:28:32, Vivek Yadav wrote:
> Whenever MCAN Buffers and FIFOs are stored on message ram, there are
                                                        RAM
> inherent risks of corruption known as single-bit errors.
>=20
> Enable error correction code (ECC) data intigrity check for Message RAM
> to create valid ECC checksums.
>=20
> ECC uses a respective number of bits, which are added to each word as a
> parity and that will raise the error signal on the corruption in the
> Interrupt Register(IR).
>=20
> Message RAM bit error controlled by input signal m_can_aeim_berr[0],
> generated by an optional external parity / ECC logic attached to the
> Message RAM.
>=20
> This indicates either Bit Error detected and Corrected(BEC) or No bit
> error detected when reading from Message RAM.

There is no ECC error handler added to the code.

> Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
> ---
>  drivers/net/can/m_can/m_can.c | 73 +++++++++++++++++++++++++++++++++++
>  drivers/net/can/m_can/m_can.h | 24 ++++++++++++
>  2 files changed, 97 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index dcb582563d5e..578146707d5b 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1535,9 +1535,62 @@ static void m_can_stop(struct net_device *dev)
>  	cdev->can.state =3D CAN_STATE_STOPPED;
>  }
> =20
> +int m_can_config_mram_ecc_check(struct m_can_classdev *cdev, int enable,
static                                                          ^^^ bool
> +				struct device_node *np)
> +{
> +	int val =3D 0;
> +	int offset =3D 0, ret =3D 0;
> +	int delay_count =3D MRAM_INIT_TIMEOUT;
> +	struct m_can_mraminit *mraminit =3D &cdev->mraminit_sys;

Please sort by reverse Christmas tree.

> +
> +	mraminit->syscon =3D syscon_regmap_lookup_by_phandle(np,
> +							   "mram-ecc-cfg");

Please check if syscon_regmap_lookup_by_phandle_args() is better suited.

You probably want to do the syscon lookup once during
m_can_class_register().

> +	if (IS_ERR(mraminit->syscon)) {
> +		/* can fail with -EPROBE_DEFER */

m_can_config_mram_ecc_check() is called from m_can_open() and
m_can_close(), returning -EPROBE_DEFER makes no sense there.

> +		ret =3D PTR_ERR(mraminit->syscon);
> +		return ret;
> +	}
> +
> +	if (of_property_read_u32_index(np, "mram-ecc-cfg", 1,
> +				       &mraminit->reg)) {
> +		dev_err(cdev->dev, "couldn't get the mraminit reg. offset!\n");
> +		return -ENODEV;
> +	}
> +
> +	val =3D ((MRAM_ECC_ENABLE_MASK | MRAM_CFG_VALID_MASK |
> +		MRAM_INIT_ENABLE_MASK) << offset);

please make use of FIELD_PREP

> +	regmap_clear_bits(mraminit->syscon, mraminit->reg, val);
> +
> +	if (enable) {
> +		val =3D (MRAM_ECC_ENABLE_MASK | MRAM_INIT_ENABLE_MASK) << offset;

same here

> +		regmap_set_bits(mraminit->syscon, mraminit->reg, val);
> +	}
> +
> +	/* after enable or disable valid flag need to be set*/
                                                           ^^^
                                                           missing space
> +	val =3D (MRAM_CFG_VALID_MASK << offset);

here, too

> +	regmap_set_bits(mraminit->syscon, mraminit->reg, val);
> +
> +	if (enable) {
> +		do {
> +			regmap_read(mraminit->syscon, mraminit->reg, &val);
> +
> +			if (val & (MRAM_INIT_DONE_MASK << offset))
> +				return 0;
> +
> +			udelay(1);
> +		} while (delay_count--);

please make use of regmap_read_poll_timeout().

> +
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static int m_can_close(struct net_device *dev)
>  {
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> +	struct device_node *np;
> +	int err =3D 0;
> =20
>  	netif_stop_queue(dev);
> =20
> @@ -1557,6 +1610,15 @@ static int m_can_close(struct net_device *dev)
>  	if (cdev->is_peripheral)
>  		can_rx_offload_disable(&cdev->offload);
> =20
> +	np =3D cdev->dev->of_node;
> +
> +	if (np && of_property_read_bool(np, "mram-ecc-cfg")) {
> +		err =3D m_can_config_mram_ecc_check(cdev, ECC_DISABLE, np);
> +		if (err < 0)
> +			netdev_err(dev,
> +				   "Message RAM ECC disable config failed\n");
> +	}
> +
>  	close_candev(dev);
> =20
>  	phy_power_off(cdev->transceiver);
> @@ -1754,6 +1816,7 @@ static int m_can_open(struct net_device *dev)
>  {
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
>  	int err;
> +	struct device_node *np;
> =20
>  	err =3D phy_power_on(cdev->transceiver);
>  	if (err)
> @@ -1798,6 +1861,16 @@ static int m_can_open(struct net_device *dev)
>  		goto exit_irq_fail;
>  	}
> =20
> +	np =3D cdev->dev->of_node;
> +
> +	if (np && of_property_read_bool(np, "mram-ecc-cfg")) {
> +		err =3D m_can_config_mram_ecc_check(cdev, ECC_ENABLE, np);
> +		if (err < 0) {
> +			netdev_err(dev,
> +				   "Message RAM ECC enable config failed\n");
> +		}
> +	}
> +
>  	/* start the m_can controller */
>  	m_can_start(dev);
> =20
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 4c0267f9f297..3cbfdc64a7db 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -28,6 +28,8 @@
>  #include <linux/can/dev.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/phy/phy.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>

please make a separate patch that sorts these includes alphabetically,
then add the new includes sorted.

> =20
>  /* m_can lec values */
>  enum m_can_lec_type {
> @@ -52,12 +54,33 @@ enum m_can_mram_cfg {
>  	MRAM_CFG_NUM,
>  };
> =20
> +enum m_can_ecc_cfg {
> +	ECC_DISABLE =3D 0,
> +	ECC_ENABLE,
> +};
> +

unused

>  /* address offset and element number for each FIFO/Buffer in the Message=
 RAM */
>  struct mram_cfg {
>  	u16 off;
>  	u8  num;
>  };
> =20
> +/* MRAM_INIT_BITS */
> +#define MRAM_CFG_VALID_SHIFT   5
> +#define MRAM_CFG_VALID_MASK    BIT(MRAM_CFG_VALID_SHIFT)
> +#define MRAM_ECC_ENABLE_SHIFT  3
> +#define MRAM_ECC_ENABLE_MASK   BIT(MRAM_ECC_ENABLE_SHIFT)
> +#define MRAM_INIT_ENABLE_SHIFT 1
> +#define MRAM_INIT_ENABLE_MASK  BIT(MRAM_INIT_ENABLE_SHIFT)
> +#define MRAM_INIT_DONE_SHIFT   0
> +#define MRAM_INIT_DONE_MASK    BIT(MRAM_INIT_DONE_SHIFT)
> +#define MRAM_INIT_TIMEOUT      50

Please move these bits to the m_can.c file.

Add a common prefix M_CAN_ to them.

Remove the SHIFT values, directly define the MASK using BIT() (for
single set bits) or GEN_MASK() (for multiple set bits).

> +
> +struct m_can_mraminit {

Is this RAM init or ECC related?

> +	struct regmap *syscon;  /* for mraminit ctrl. reg. access */
> +	unsigned int reg;       /* register index within syscon */
> +};
> +
>  struct m_can_classdev;
>  struct m_can_ops {
>  	/* Device specific call backs */
> @@ -92,6 +115,7 @@ struct m_can_classdev {
>  	int pm_clock_support;
>  	int is_peripheral;
> =20
> +	struct m_can_mraminit mraminit_sys;     /* mraminit via syscon regmap */
>  	struct mram_cfg mcfg[MRAM_CFG_NUM];
>  };
> =20
> --=20
> 2.17.1
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--244jhurzphrta6mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNXm0gACgkQrX5LkNig
013wJgf/YRD0HA2nNrMxl28Z1hEUp7YGbykkJpHze+nWAotj/LwvbmVjPtvFkuNs
Dxc1LSHtJn66DcIrHX7Tkcvs9q8px/Y7JpG6AMWngTCF44kISPRvDoYATl9WIcrD
O7DHCUVxcQeVlcAVteYRQiT2g1XfgLq8eKHVyiGs3aPX7/3/QtNP2qhzQ086iHU3
jrpcuWB5Z60qELuPLY7mNn82jxf9wRrHMMhylYFnWR1G8FZkf0lg4aS/CIaSNVKy
f7WqbQPQhtt/FIBAIOYvAXQuuqfFkJjNd60hknRZ4J9Uxg1lJGLHFMJyUM8xb4FW
swTTdXe30BlLGrhHPUXfDl5ZCDFqyw==
=7EVA
-----END PGP SIGNATURE-----

--244jhurzphrta6mf--
