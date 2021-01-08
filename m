Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB4D2EEEB4
	for <lists+linux-can@lfdr.de>; Fri,  8 Jan 2021 09:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbhAHImB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 8 Jan 2021 03:42:01 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:56505 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbhAHImA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jan 2021 03:42:00 -0500
Received: from [100.113.1.5] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id CF/E1-07430-41A18FF5; Fri, 08 Jan 2021 08:38:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRWlGSWpSXmKPExsUS8J9toq6w1I9
  4gyf/LSz+zPzAZHG2+xqjxarvU5ktLu+aw2bxqvkRm8X6RVNYLDZ1Xmaz2Dv1AaPF2U0rmSyW
  3tvJ6sDlsXPWXXaPj5duM3os3vOSyaN79j8Wj/UbtjF69P818Dg4pZvN41TPamaPz5vkAjijW
  DPzkvIrElgzuu+dYi5YalVx8cYJ1gbGv3pdjFwcQgINjBJX/t5g7WLk5JAQ8JPoeP6SDSKxiV
  Hi4qK5zBDOG0aJXZ3bmECqhAT2MEoceB4BYgsLBEhM370dqIiDQ0QgWeLrhHqQemaB2UwS71Y
  1sEM0z2eUuHdjIRtIA5uAmcT6F8+YQWxeAVuJE90vWUCaWQRUJLYuZQEJiwpESCzc38kKUSIo
  cXLmE7A4p4CTxIV319lAypkFNCXW79IHCTMLiEvcejKfCcLWlli28DUzxJmaEmtOrWGGeExBY
  tKsp0wgrRICcRJf7phChDkl3n/4ABW2lpi4OREirCYxf3EX4wRGiVlIbpiFsHcWkr2zkOxdwM
  iyitEyqSgzPaMkNzEzR9fQwEDX0NBY11DXyMhML7FKN1EvtVQ3OTWvpCgRKKuXWF6sV1yZm5y
  TopeXWrKJEZg6UgoZH+1gPP36g94hRkkOJiVR3lvvvscL8SXlp1RmJBZnxBeV5qQWH2KU4eBQ
  kuA9LPEjXkiwKDU9tSItMweYxmDSEhw8SiK8bpJAad7igsTc4sx0iNQpRl2Om++XLGIWYsnLz
  0uVEuflAikSACnKKM2DGwFLqZcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfP6glzCk5lXAr
  fpFdARTEBH5Hl9BzmiJBEhJdXAJCt3V+FwpYKEp1TLidt+K73jArfeKvM4V23HYtQYZOmyrV7
  Uuu45Q7HV57SGzbV3BGMWzi66tP/3sY+pG90S90+Z+iDVSvx3zfHk13n7uvatUeo+fHqatozP
  0t9/c00siwMfpbzz+ZJ/2ztmjSHn642Vvk/8jjp6avxunrW56MnalZJOwWsqa/cc2uhkLXM37
  Y3yT+7tP+QNXv4R+b/54O5VPNXTY6PTRD0mVdTELNzEGNJziO0s9/k96/p+8FVIanP7C6r0XL
  m3aupl9wes/Spl5UxXBM5saPhVsC/FrGXr0kpLMZGk90qVa84FPnymGrH4k+GUz9sm9zs/Exb
  zunT93vYtgTJhOqJZhiVRSizFGYmGWsxFxYkAOqDHeSQEAAA=
X-Env-Sender: Abhijeet.Badurkar@duagon.com
X-Msg-Ref: server-7.tower-223.messagelabs.com!1610095123!1238391!1
X-Originating-IP: [80.255.6.145]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9652 invoked from network); 8 Jan 2021 08:38:43 -0000
Received: from unknown (HELO keys.men.de) (80.255.6.145)
  by server-7.tower-223.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 8 Jan 2021 08:38:43 -0000
Received: from MEN-EX01.intra.men.de ([192.168.1.1])
  by keys.men.de (PGP Universal service);
  Fri, 08 Jan 2021 09:38:43 +0100
X-PGP-Universal: processed;
        by keys.men.de on Fri, 08 Jan 2021 09:38:43 +0100
Received: from WSRV-EXHybrid.intra.men.de (192.168.1.226) by
 MEN-EX01.intra.men.de (192.168.1.1) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Jan 2021 09:38:42 +0100
Received: from MEN-EX01.intra.men.de (192.168.1.1) by
 WSRV-EXHybrid.intra.men.de (192.168.1.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 8 Jan 2021 09:38:42 +0100
Received: from [10.64.14.204] (10.64.14.204) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 09:38:42 +0100
Subject: Re: [PATCH v5] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>, <wg@grandegger.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <andreas.geissler@duagon.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        <openrisc@lists.librecores.org>
References: <20201005112033.21438-1-abhijeet.badurkar@duagon.com>
 <202010160751.lNyADAMs-lkp@intel.com>
 <81bbd71a-ff79-9f15-753a-d47b36b91756@pengutronix.de>
From:   Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
Message-ID: <24882539-577e-9a04-d184-6b5818b63b8b@duagon.com>
Date:   Fri, 8 Jan 2021 09:38:40 +0100
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
X-Loop: 2
X-EXCLAIMER-MD-CONFIG: e4841e51-7998-49c0-ba41-8b8a0e2d8962
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
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
Yes, only the iounmap of openrisc arch has the problem. Is there any specific reason why it does not have __iomem annotation? What's the possible way to fix this? Wait for iounmap funtion of openrisc to get fixed?
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

 
