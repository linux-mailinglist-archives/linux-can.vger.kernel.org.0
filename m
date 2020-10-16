Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAEE28FF91
	for <lists+linux-can@lfdr.de>; Fri, 16 Oct 2020 09:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404883AbgJPH4A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Oct 2020 03:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404926AbgJPH4A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Oct 2020 03:56:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2225C061755
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2020 00:55:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kTKaY-0000cX-Vc; Fri, 16 Oct 2020 09:55:47 +0200
Received: from [IPv6:2a03:f580:87bc:d400:c4e8:c8ff:a41:29c1] (unknown [IPv6:2a03:f580:87bc:d400:c4e8:c8ff:a41:29c1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3F57B57A761;
        Fri, 16 Oct 2020 07:55:41 +0000 (UTC)
To:     kernel test robot <lkp@intel.com>,
        Abhijeet Badurkar <abhijeet.badurkar@duagon.com>,
        wg@grandegger.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, andreas.geissler@duagon.com,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
References: <20201005112033.21438-1-abhijeet.badurkar@duagon.com>
 <202010160751.lNyADAMs-lkp@intel.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v5] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
Message-ID: <81bbd71a-ff79-9f15-753a-d47b36b91756@pengutronix.de>
Date:   Fri, 16 Oct 2020 09:55:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <202010160751.lNyADAMs-lkp@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OAJKB8Pl5sQJ3Uww3LbktN3hjUPc5ytbg"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OAJKB8Pl5sQJ3Uww3LbktN3hjUPc5ytbg
Content-Type: multipart/mixed; boundary="jEMnS08L6hdDgHY61t8gtMQENSnJGgVZZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kernel test robot <lkp@intel.com>,
 Abhijeet Badurkar <abhijeet.badurkar@duagon.com>, wg@grandegger.com
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, andreas.geissler@duagon.com,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org
Message-ID: <81bbd71a-ff79-9f15-753a-d47b36b91756@pengutronix.de>
Subject: Re: [PATCH v5] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
References: <20201005112033.21438-1-abhijeet.badurkar@duagon.com>
 <202010160751.lNyADAMs-lkp@intel.com>
In-Reply-To: <202010160751.lNyADAMs-lkp@intel.com>

--jEMnS08L6hdDgHY61t8gtMQENSnJGgVZZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/16/20 1:49 AM, kernel test robot wrote:
> Hi Abhijeet,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on 549738f15da0e5a00275977623be199fbbf7df50]
>=20
> url:    https://github.com/0day-ci/linux/commits/Abhijeet-Badurkar/net-=
can-Introduce-MEN-16Z192-00-CAN-controller-driver/20201005-192132
> base:    549738f15da0e5a00275977623be199fbbf7df50
> config: openrisc-randconfig-s031-20201015 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-rc1-dirty
>         # https://github.com/0day-ci/linux/commit/267876771a434b2be3278=
c2c87d36146c0fac77d
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Abhijeet-Badurkar/net-can-Intr=
oduce-MEN-16Z192-00-CAN-controller-driver/20201005-192132
>         git checkout 267876771a434b2be3278c2c87d36146c0fac77d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cr=
oss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dopenrisc=20

I think it's the openrisc arch to blame^w ask here, since their iounmap d=
oesn't
have __iomem annotation.

>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> "sparse warnings: (new ones prefixed by >>)"
>>> drivers/net/can/men_z192_can.c:1057:17: sparse: sparse: incorrect typ=
e in argument 1 (different address spaces) @@     expected void *addr @@ =
    got void [noderef] __iomem *[assigned] dev_base @@
>>> drivers/net/can/men_z192_can.c:1057:17: sparse:     expected void *ad=
dr
>>> drivers/net/can/men_z192_can.c:1057:17: sparse:     got void [noderef=
] __iomem *[assigned] dev_base
>>> drivers/net/can/men_z192_can.c:1071:21: sparse: sparse: incorrect typ=
e in argument 1 (different address spaces) @@     expected void *addr @@ =
    got void [noderef] __iomem *dev_base @@
>    drivers/net/can/men_z192_can.c:1071:21: sparse:     expected void *a=
ddr
>>> drivers/net/can/men_z192_can.c:1071:21: sparse:     got void [noderef=
] __iomem *dev_base
>=20
> vim +1057 drivers/net/can/men_z192_can.c
>=20
>    962=09
>    963	static int men_z192_probe(struct mcb_device *mdev,
>    964				  const struct mcb_device_id *id)
>    965	{
>    966		struct device *dev =3D &mdev->dev;
>    967		struct men_z192 *priv;
>    968		struct net_device *ndev;
>    969		void __iomem *dev_base;
>    970		struct resource *mem;
>    971		u32 timebase;
>    972		int ret =3D 0;
>    973		int irq;
>    974=09
>    975		mem =3D mcb_request_mem(mdev, dev_name(dev));
>    976		if (IS_ERR(mem)) {
>    977			dev_err(dev, "failed to request device memory");
>    978			return PTR_ERR(mem);
>    979		}
>    980=09
>    981		dev_base =3D ioremap(mem->start, resource_size(mem));
>    982		if (!dev_base) {
>    983			dev_err(dev, "failed to ioremap device memory");
>    984			ret =3D -ENXIO;
>    985			goto out_release;
>    986		}
>    987=09
>    988		irq =3D mcb_get_irq(mdev);
>    989		if (irq <=3D 0) {
>    990			ret =3D -ENODEV;
>    991			goto out_unmap;
>    992		}
>    993=09
>    994		ndev =3D alloc_candev(sizeof(struct men_z192), 0);
>    995		if (!ndev) {
>    996			dev_err(dev, "failed to allocat the can device");
>    997			ret =3D -ENOMEM;
>    998			goto out_unmap;
>    999		}
>   1000=09
>   1001		ndev->netdev_ops =3D &men_z192_netdev_ops;
>   1002		ndev->irq =3D irq;
>   1003		ndev->flags |=3D IFF_ECHO;
>   1004=09
>   1005		priv =3D netdev_priv(ndev);
>   1006		priv->ndev =3D ndev;
>   1007		priv->dev =3D dev;
>   1008=09
>   1009		priv->mem =3D mem;
>   1010		priv->dev_base =3D dev_base;
>   1011		priv->regs =3D priv->dev_base + MEN_Z192_REGS_OFFS;
>   1012=09
>   1013		timebase =3D readl(&priv->regs->timebase);
>   1014		if (!timebase) {
>   1015			dev_err(dev, "invalid timebase configured (timebase=3D%d)\n",
>   1016				timebase);
>   1017			ret =3D -EINVAL;
>   1018			goto out_free_candev;
>   1019		}
>   1020=09
>   1021		priv->can.clock.freq =3D timebase;
>   1022		priv->can.bittiming_const =3D &men_z192_bittiming_const;
>   1023		priv->can.do_set_mode =3D men_z192_set_mode;
>   1024		priv->can.do_get_berr_counter =3D men_z192_get_berr_counter;
>   1025		priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY |
>   1026					       CAN_CTRLMODE_3_SAMPLES |
>   1027					       CAN_CTRLMODE_LOOPBACK;
>   1028=09
>   1029		spin_lock_init(&priv->lock);
>   1030=09
>   1031		netif_napi_add(ndev, &priv->napi, men_z192_poll,
>   1032			       NAPI_POLL_WEIGHT);
>   1033=09
>   1034		skb_queue_head_init(&priv->echoq);
>   1035=09
>   1036		mcb_set_drvdata(mdev, ndev);
>   1037		SET_NETDEV_DEV(ndev, dev);
>   1038=09
>   1039		ndev->ethtool_ops =3D &men_z192_ethtool_ops;
>   1040=09
>   1041		ret =3D men_z192_register(ndev);
>   1042		if (ret) {
>   1043			dev_err(dev, "failed to register CAN device");
>   1044			goto out_free_candev;
>   1045		}
>   1046=09
>   1047		devm_can_led_init(ndev);
>   1048=09
>   1049		dev_info(dev, "MEN 16z192 CAN driver successfully registered\n"=
);
>   1050=09
>   1051		return 0;
>   1052=09
>   1053	out_free_candev:
>   1054		netif_napi_del(&priv->napi);
>   1055		free_candev(ndev);
>   1056	out_unmap:
>> 1057		iounmap(dev_base);
>   1058	out_release:
>   1059		mcb_release_mem(mem);
>   1060		return ret;
>   1061	}
>   1062=09
>   1063	static void men_z192_remove(struct mcb_device *mdev)
>   1064	{
>   1065		struct net_device *ndev =3D mcb_get_drvdata(mdev);
>   1066		struct men_z192 *priv =3D netdev_priv(ndev);
>   1067=09
>   1068		unregister_candev(ndev);
>   1069		netif_napi_del(&priv->napi);
>   1070=09
>> 1071		iounmap(priv->dev_base);
>   1072		mcb_release_mem(priv->mem);
>   1073=09
>   1074		free_candev(ndev);
>   1075	}
>   1076=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--jEMnS08L6hdDgHY61t8gtMQENSnJGgVZZ--

--OAJKB8Pl5sQJ3Uww3LbktN3hjUPc5ytbg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+JUfkACgkQqclaivrt
76k/XAf8CWG5GzoolwGM5Up5BjtX71R79AZZLFoB07G2JhRdazsHZUnq4ldtF9yH
4xchcNBvEsnLZ4xnMut316scjVbELtDs3DZH4A1Ar3hjF9kPtp/21olaXALLKzK+
UH/np4ANe9apmFdwj/HfG1EpcQNxcZLejom8/88XIk23J8UvkoeRzC5th90o5uTI
ot+qM8IJxx5KfYYVr2njrYR+zo47hT0lVbCq4s007hURVVlpUg1ZqDJudKza7ePP
JCs/8R8uosjU5qTZ0EygLpGGLfUhNfYMZDw7eXSX0sn7UxwyuWo+UIEyYxAQdTUS
p4T9R+JiwHvXOBPWkQ+lg19xqTATPg==
=S/UB
-----END PGP SIGNATURE-----

--OAJKB8Pl5sQJ3Uww3LbktN3hjUPc5ytbg--
