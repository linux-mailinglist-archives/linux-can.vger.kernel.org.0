Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C82EAF8D
	for <lists+linux-can@lfdr.de>; Tue,  5 Jan 2021 17:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbhAEQDu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 5 Jan 2021 11:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbhAEQDu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Jan 2021 11:03:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D88C061574
        for <linux-can@vger.kernel.org>; Tue,  5 Jan 2021 08:03:09 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kwonc-0001mM-60
        for linux-can@vger.kernel.org; Tue, 05 Jan 2021 17:03:08 +0100
Received: from [IPv6:2a03:f580:87bc:d400:3d26:d714:c11:4328] (unknown [IPv6:2a03:f580:87bc:d400:3d26:d714:c11:4328])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 69B465BA301
        for <linux-can@vger.kernel.org>; Tue,  5 Jan 2021 16:03:07 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id 0KM2LTaN9F/9NAAAs6a69A
        (envelope-from <Abhijeet.Badurkar@duagon.com>)
        for <mkl-all@blackshift.org>; Tue, 05 Jan 2021 16:00:54 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 84D595BA2FD
        for <mkl-all@blackshift.org>; Tue,  5 Jan 2021 16:00:54 +0000 (UTC)
Received: from metis.ext.pengutronix.de (unknown [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 33EA85BA2FC
        for <ptx@kleine-budde.de>; Tue,  5 Jan 2021 16:00:54 +0000 (UTC)
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <Abhijeet.Badurkar@duagon.com>)
        id 1kwolP-0001Yp-0A
        for mkl@pengutronix.de; Tue, 05 Jan 2021 17:00:52 +0100
Received: from [100.112.193.227] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id A4/E9-56778-13D84FF5; Tue, 05 Jan 2021 16:00:49 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRWlGSWpSXmKPExsUS8J9toq5h75d
  4gx/f5SzWL5rC4sDo0f/XIIAxijUzLym/IoE1Y/aDeywF5y0rLm2cyNzAuFOvi5GLQ0iggVHi
  4PRjTF2MnBwSAn4Sjy+3sUMkVjNKnN8yjwXC2cMosfj5LzaQKmGBAInpu7czg9giAloStz9uZ
  4Moms8oce/GQiCHg4NZwEji6Y4KkBo2ATOJ9S+egdXzCthK/P6zH2wbi4CKxOnlc1hBbFGBCI
  mF+ztZIWoEJU7OfMICYnMKOElceHcdaqSmxPpd+iBhZgFxiVtP5jNB2NoSyxa+BhsvBFSy5tQ
  aZohnFCQmzXrKBNIqIRAn8eWOKYRpLTFxcyJEhZrE/MVdjBA2p8T7Dx+YJjCKz0JywyyEvbOQ
  7J2FZO8CRpZVjOZJRZnpGSW5iZk5uoYGBrqGhka6hpZGuiYmeolVuol6qaW65anFJbqGeonlx
  XrFlbnJOSl6eaklmxiBcZdScEBnB+PPVx/0DjFKcjApifJOi/4SL8SXlJ9SmZFYnBFfVJqTWn
  yIUYaDQ0mC92knUE6wKDU9tSItMweYAmDSEhw8SiK8Ft1Aad7igsTc4sx0iNQpRl2Om++XLGI
  WYsnLz0uVEuflACkSACnKKM2DGwFLR5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfMuBJnC
  k5lXArfpFdARTEBHHA79DHJESSJCSqqBacE0wVd3xG3/GJdM61tnLu7UmWmtPOtVZtt8Dmath
  U+1/QK2vw+9+PGqxu+Teu+b20oL7zra9L75I2artu9sedJ1oZKXpv6utZbK/j7KP9a9Teuf+y
  qU6YQgm73D579Mb37clkqrS1s3Tc+Qs7yRO7m3sv84/55/9z059d4pHzy24cwyBoMVSSnTPKI
  1i5U3r9mufEdAcV/WcavnetJ3p3zYcuzx32nnYi+KJjkI1c1YIuinmNznzRP5eOI/rvIP3jva
  78+OSFx/MkL3/z8zmecnJ+y6Xj9TvITvQ+Dru2V168+aV1ypkz8oLZ6Sy7j82yuB3DesfxrtD
  xZuuTUnZtvZovexlkeMqlr3LljhrcRSnJFoqMVcVJwIAH5SG3fCAwAA
X-Env-Sender: Abhijeet.Badurkar@duagon.com
X-Msg-Ref: server-21.tower-272.messagelabs.com!1609862448!3581671!1
X-Originating-IP: [80.255.6.145]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31471 invoked from network); 5 Jan 2021 16:00:49 -0000
Received: from unknown (HELO keys.men.de) (80.255.6.145)
  by server-21.tower-272.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 5 Jan 2021 16:00:49 -0000
Received: from MEN-EX01.intra.men.de ([192.168.1.1])
  by keys.men.de (PGP Universal service);
  Tue, 05 Jan 2021 17:00:49 +0100
X-PGP-Universal: processed;
        by keys.men.de on Tue, 05 Jan 2021 17:00:49 +0100
Received: from MEN-EX01.intra.men.de (192.168.1.1) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 Jan
 2021 17:00:48 +0100
Received: from [10.64.14.204] (10.64.14.204) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 17:00:48 +0100
To:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20201005112033.21438-1-abhijeet.badurkar@duagon.com>
 <202010160751.lNyADAMs-lkp@intel.com>
 <81bbd71a-ff79-9f15-753a-d47b36b91756@pengutronix.de>
CC:     andreas Geissler <andreas.geissler@duagon.com>
From:   Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
Message-ID: <b3948f68-9b6a-65c5-2bd5-a07684d47f9e@duagon.com>
Date:   Tue, 5 Jan 2021 17:00:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <81bbd71a-ff79-9f15-753a-d47b36b91756@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.64.14.204]
X-ClientProxiedBy: MEN-EX01.intra.men.de (192.168.1.1) To
 MEN-EX01.intra.men.de (192.168.1.1)
X-EXCLAIMER-MD-CONFIG: e4841e51-7998-49c0-ba41-8b8a0e2d8962
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Loop: 2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=4.0 tests=AWL,BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v5] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

﻿



M. Sc.
Abhijeet Badurkar
Software Engineering 
Business Unit Computing Systems, duagon

duagon Germany GmbH
Neuwieder Straße 1-7
90411 Nürnberg
Deutschland
Phone		+49 911 99 33 5 - 219
www.duagon.com

duagon Germany GmbH - Geschäftsführer: Dr. Michael Goldbach - Mathias Kamolz - Kalina Scott - Handelsregister/Trade Register AG Nürnberg HRB 5540

This message and/or attachments may be privileged or confidential. If you are not the intended recipient, you are hereby notified that you have received this transmittal in error; any review, dissemination, or copying is strictly prohibited. If you received this transmittal in error, please notify us immediately by reply and immediately delete this message and all its attachments. Thank you.
On 16.10.20 09:55, Marc Kleine-Budde wrote:
> * PGP Signed by an unknown key
> 
> On 10/16/20 1:49 AM, kernel test robot wrote:
>> Hi Abhijeet,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on 549738f15da0e5a00275977623be199fbbf7df50]
>>
>> url:    https://github.com/0day-ci/linux/commits/Abhijeet-Badurkar/net-can-Introduce-MEN-16Z192-00-CAN-controller-driver/20201005-192132
>> base:    549738f15da0e5a00275977623be199fbbf7df50
>> config: openrisc-randconfig-s031-20201015 (attached as .config)
>> compiler: or1k-linux-gcc (GCC) 9.3.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # apt-get install sparse
>>         # sparse version: v0.6.3-rc1-dirty
>>         # https://github.com/0day-ci/linux/commit/267876771a434b2be3278c2c87d36146c0fac77d
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Abhijeet-Badurkar/net-can-Introduce-MEN-16Z192-00-CAN-controller-driver/20201005-192132
>>         git checkout 267876771a434b2be3278c2c87d36146c0fac77d
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 
> 
> I think it's the openrisc arch to blame^w ask here, since their iounmap doesn't
> have __iomem annotation.
Yes, all other architectures have __iomem annotation. What's the way to fix this? Wait for openrisc iounmap function to be fixed?
> 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> "sparse warnings: (new ones prefixed by >>)"
>>>> drivers/net/can/men_z192_can.c:1057:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] dev_base @@
>>>> drivers/net/can/men_z192_can.c:1057:17: sparse:     expected void *addr
>>>> drivers/net/can/men_z192_can.c:1057:17: sparse:     got void [noderef] __iomem *[assigned] dev_base
>>>> drivers/net/can/men_z192_can.c:1071:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *dev_base @@
>>    drivers/net/can/men_z192_can.c:1071:21: sparse:     expected void *addr
>>>> drivers/net/can/men_z192_can.c:1071:21: sparse:     got void [noderef] __iomem *dev_base
>>
>> vim +1057 drivers/net/can/men_z192_can.c
>>
>>    962	
>>    963	static int men_z192_probe(struct mcb_device *mdev,
>>    964				  const struct mcb_device_id *id)
>>    965	{
>>    966		struct device *dev = &mdev->dev;
>>    967		struct men_z192 *priv;
>>    968		struct net_device *ndev;
>>    969		void __iomem *dev_base;
>>    970		struct resource *mem;
>>    971		u32 timebase;
>>    972		int ret = 0;
>>    973		int irq;
>>    974	
>>    975		mem = mcb_request_mem(mdev, dev_name(dev));
>>    976		if (IS_ERR(mem)) {
>>    977			dev_err(dev, "failed to request device memory");
>>    978			return PTR_ERR(mem);
>>    979		}
>>    980	
>>    981		dev_base = ioremap(mem->start, resource_size(mem));
>>    982		if (!dev_base) {
>>    983			dev_err(dev, "failed to ioremap device memory");
>>    984			ret = -ENXIO;
>>    985			goto out_release;
>>    986		}
>>    987	
>>    988		irq = mcb_get_irq(mdev);
>>    989		if (irq <= 0) {
>>    990			ret = -ENODEV;
>>    991			goto out_unmap;
>>    992		}
>>    993	
>>    994		ndev = alloc_candev(sizeof(struct men_z192), 0);
>>    995		if (!ndev) {
>>    996			dev_err(dev, "failed to allocat the can device");
>>    997			ret = -ENOMEM;
>>    998			goto out_unmap;
>>    999		}
>>   1000	
>>   1001		ndev->netdev_ops = &men_z192_netdev_ops;
>>   1002		ndev->irq = irq;
>>   1003		ndev->flags |= IFF_ECHO;
>>   1004	
>>   1005		priv = netdev_priv(ndev);
>>   1006		priv->ndev = ndev;
>>   1007		priv->dev = dev;
>>   1008	
>>   1009		priv->mem = mem;
>>   1010		priv->dev_base = dev_base;
>>   1011		priv->regs = priv->dev_base + MEN_Z192_REGS_OFFS;
>>   1012	
>>   1013		timebase = readl(&priv->regs->timebase);
>>   1014		if (!timebase) {
>>   1015			dev_err(dev, "invalid timebase configured (timebase=%d)\n",
>>   1016				timebase);
>>   1017			ret = -EINVAL;
>>   1018			goto out_free_candev;
>>   1019		}
>>   1020	
>>   1021		priv->can.clock.freq = timebase;
>>   1022		priv->can.bittiming_const = &men_z192_bittiming_const;
>>   1023		priv->can.do_set_mode = men_z192_set_mode;
>>   1024		priv->can.do_get_berr_counter = men_z192_get_berr_counter;
>>   1025		priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
>>   1026					       CAN_CTRLMODE_3_SAMPLES |
>>   1027					       CAN_CTRLMODE_LOOPBACK;
>>   1028	
>>   1029		spin_lock_init(&priv->lock);
>>   1030	
>>   1031		netif_napi_add(ndev, &priv->napi, men_z192_poll,
>>   1032			       NAPI_POLL_WEIGHT);
>>   1033	
>>   1034		skb_queue_head_init(&priv->echoq);
>>   1035	
>>   1036		mcb_set_drvdata(mdev, ndev);
>>   1037		SET_NETDEV_DEV(ndev, dev);
>>   1038	
>>   1039		ndev->ethtool_ops = &men_z192_ethtool_ops;
>>   1040	
>>   1041		ret = men_z192_register(ndev);
>>   1042		if (ret) {
>>   1043			dev_err(dev, "failed to register CAN device");
>>   1044			goto out_free_candev;
>>   1045		}
>>   1046	
>>   1047		devm_can_led_init(ndev);
>>   1048	
>>   1049		dev_info(dev, "MEN 16z192 CAN driver successfully registered\n");
>>   1050	
>>   1051		return 0;
>>   1052	
>>   1053	out_free_candev:
>>   1054		netif_napi_del(&priv->napi);
>>   1055		free_candev(ndev);
>>   1056	out_unmap:
>>> 1057		iounmap(dev_base);
>>   1058	out_release:
>>   1059		mcb_release_mem(mem);
>>   1060		return ret;
>>   1061	}
>>   1062	
>>   1063	static void men_z192_remove(struct mcb_device *mdev)
>>   1064	{
>>   1065		struct net_device *ndev = mcb_get_drvdata(mdev);
>>   1066		struct men_z192 *priv = netdev_priv(ndev);
>>   1067	
>>   1068		unregister_candev(ndev);
>>   1069		netif_napi_del(&priv->napi);
>>   1070	
>>> 1071		iounmap(priv->dev_base);
>>   1072		mcb_release_mem(priv->mem);
>>   1073	
>>   1074		free_candev(ndev);
>>   1075	}
>>   1076	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 
> Marc
> 

-- 
Abhijeet Badurkar - Software Engineer

 
