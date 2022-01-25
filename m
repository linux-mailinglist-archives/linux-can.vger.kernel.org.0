Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A962049AE8A
	for <lists+linux-can@lfdr.de>; Tue, 25 Jan 2022 09:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384951AbiAYIvP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jan 2022 03:51:15 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:58709 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452327AbiAYIs3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jan 2022 03:48:29 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D34ED100002;
        Tue, 25 Jan 2022 08:48:15 +0000 (UTC)
Date:   Tue, 25 Jan 2022 09:48:15 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Dario Binacchi <dariobin@libero.it>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 7/9] can: drivers: don't print IO remapped address of
 base registers
Message-ID: <Ye+5TxMra44fpjIy@piout.net>
References: <20220124215642.3474154-1-mkl@pengutronix.de>
 <20220124215642.3474154-8-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124215642.3474154-8-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

On 24/01/2022 22:56:40+0100, Marc Kleine-Budde wrote:
> This patch removes the printing of the IO remapped base registers of
> all CAN devices. As documented in
> 
> | Documentation/core-api/printk-formats.rst,
> 
> to prevent information leaks a hashed value of the address is printed,
> until the kernel gathers enough entropy only "(ptrval)" is displayed.
> 
> This patch removes the printing of the base address as the information
> is not really useful.

Is the info useful at all? I guess most of the instances could be
replaced by a single dev_info in the can core once the device is
registered and the other ones are failures where the device probing
code would already print the failure.

> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Dario Binacchi <dariobin@libero.it>
> Cc: Zheyu Ma <zheyuma97@gmail.com>
> Cc: Stephane Grosjean <s.grosjean@peak-system.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: linux-sunxi@lists.linux.dev
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/at91_can.c                    | 3 +--
>  drivers/net/can/c_can/c_can_pci.c             | 4 ++--
>  drivers/net/can/c_can/c_can_platform.c        | 4 ++--
>  drivers/net/can/cc770/cc770.c                 | 6 ++----
>  drivers/net/can/cc770/cc770_isa.c             | 3 +--
>  drivers/net/can/cc770/cc770_platform.c        | 4 ++--
>  drivers/net/can/grcan.c                       | 4 ++--
>  drivers/net/can/ifi_canfd/ifi_canfd.c         | 4 ++--
>  drivers/net/can/mscan/mpc5xxx_can.c           | 4 ++--
>  drivers/net/can/peak_canfd/peak_pciefd_main.c | 4 ++--
>  drivers/net/can/sja1000/ems_pci.c             | 4 ++--
>  drivers/net/can/sja1000/ems_pcmcia.c          | 4 ++--
>  drivers/net/can/sja1000/f81601.c              | 4 ++--
>  drivers/net/can/sja1000/kvaser_pci.c          | 3 +--
>  drivers/net/can/sja1000/peak_pci.c            | 4 +---
>  drivers/net/can/sja1000/peak_pcmcia.c         | 4 ++--
>  drivers/net/can/sja1000/plx_pci.c             | 4 ++--
>  drivers/net/can/sja1000/sja1000_isa.c         | 4 ++--
>  drivers/net/can/sja1000/sja1000_platform.c    | 4 ++--
>  drivers/net/can/sun4i_can.c                   | 4 ++--
>  drivers/net/can/ti_hecc.c                     | 3 +--
>  drivers/net/can/xilinx_can.c                  | 4 ++--
>  22 files changed, 39 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index a00655ccda02..5a7f96791014 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -1333,8 +1333,7 @@ static int at91_can_probe(struct platform_device *pdev)
>  
>  	devm_can_led_init(dev);
>  
> -	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
> -		 priv->reg_base, dev->irq);
> +	dev_info(&pdev->dev, "device registered (irq=%d)\n", dev->irq);
>  
>  	return 0;
>  
> diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
> index bf2f8c3da1c1..5992a712acdb 100644
> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -216,8 +216,8 @@ static int c_can_pci_probe(struct pci_dev *pdev,
>  		goto out_free_c_can;
>  	}
>  
> -	dev_dbg(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
> -		KBUILD_MODNAME, priv->regs, dev->irq);
> +	dev_dbg(&pdev->dev, "%s device registered (irq=%d)\n",
> +		KBUILD_MODNAME, dev->irq);
>  
>  	return 0;
>  
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> index 86e95e9d6533..2f089098da90 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -398,8 +398,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
>  		goto exit_free_device;
>  	}
>  
> -	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
> -		 KBUILD_MODNAME, priv->base, dev->irq);
> +	dev_info(&pdev->dev, "%s device registered (irq=%d)\n",
> +		 KBUILD_MODNAME, dev->irq);
>  	return 0;
>  
>  exit_free_device:
> diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
> index bb7224cfc6ab..4ebac0312a18 100644
> --- a/drivers/net/can/cc770/cc770.c
> +++ b/drivers/net/can/cc770/cc770.c
> @@ -300,8 +300,7 @@ static int cc770_probe_chip(struct net_device *dev)
>  	 * is no chip in this address space
>  	 */
>  	if (cc770_read_reg(priv, cpu_interface) & CPUIF_RST) {
> -		netdev_info(dev, "probing @0x%p failed (reset)\n",
> -			    priv->reg_base);
> +		netdev_info(dev, "probing failed (reset)\n");
>  		return -ENODEV;
>  	}
>  
> @@ -312,8 +311,7 @@ static int cc770_probe_chip(struct net_device *dev)
>  	if ((cc770_read_reg(priv, msgobj[1].data[1]) != 0x25) ||
>  	    (cc770_read_reg(priv, msgobj[2].data[3]) != 0x52) ||
>  	    (cc770_read_reg(priv, msgobj[10].data[6]) != 0xc3)) {
> -		netdev_info(dev, "probing @0x%p failed (pattern)\n",
> -			    priv->reg_base);
> +		netdev_info(dev, "probing failed (pattern)\n");
>  		return -ENODEV;
>  	}
>  
> diff --git a/drivers/net/can/cc770/cc770_isa.c b/drivers/net/can/cc770/cc770_isa.c
> index 194c86e0f340..372de4d18a7f 100644
> --- a/drivers/net/can/cc770/cc770_isa.c
> +++ b/drivers/net/can/cc770/cc770_isa.c
> @@ -267,8 +267,7 @@ static int cc770_isa_probe(struct platform_device *pdev)
>  		goto exit_unmap;
>  	}
>  
> -	dev_info(&pdev->dev, "device registered (reg_base=0x%p, irq=%d)\n",
> -		 priv->reg_base, dev->irq);
> +	dev_info(&pdev->dev, "device registered (irq=%d)\n", dev->irq);
>  	return 0;
>  
>   exit_unmap:
> diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
> index 8d916e2ee6c2..2049921eed89 100644
> --- a/drivers/net/can/cc770/cc770_platform.c
> +++ b/drivers/net/can/cc770/cc770_platform.c
> @@ -203,9 +203,9 @@ static int cc770_platform_probe(struct platform_device *pdev)
>  		goto exit_free_cc770;
>  
>  	dev_dbg(&pdev->dev,
> -		 "reg_base=0x%p irq=%d clock=%d cpu_interface=0x%02x "
> +		 "irq=%d clock=%d cpu_interface=0x%02x "
>  		 "bus_config=0x%02x clkout=0x%02x\n",
> -		 priv->reg_base, dev->irq, priv->can.clock.freq,
> +		 dev->irq, priv->can.clock.freq,
>  		 priv->cpu_interface, priv->bus_config, priv->clkout);
>  
>  	platform_set_drvdata(pdev, dev);
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index d0c5a7a60daf..80e1485675a9 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -1616,8 +1616,8 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
>  	netif_napi_add(dev, &priv->napi, grcan_poll, GRCAN_NAPI_WEIGHT);
>  
>  	SET_NETDEV_DEV(dev, &ofdev->dev);
> -	dev_info(&ofdev->dev, "regs=0x%p, irq=%d, clock=%d\n",
> -		 priv->regs, dev->irq, priv->can.clock.freq);
> +	dev_info(&ofdev->dev, "irq=%d, clock=%d\n",
> +		 dev->irq, priv->can.clock.freq);
>  
>  	err = register_candev(dev);
>  	if (err)
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
> index b0a3473f211d..82aeac04ad89 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -1006,8 +1006,8 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
>  
>  	devm_can_led_init(ndev);
>  
> -	dev_info(dev, "Driver registered: regs=%p, irq=%d, clock=%d\n",
> -		 priv->base, ndev->irq, priv->can.clock.freq);
> +	dev_info(dev, "Driver registered: irq=%d, clock=%d\n",
> +		 ndev->irq, priv->can.clock.freq);
>  
>  	return 0;
>  
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
> index de4ddf79ba9b..3d577489b5fb 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -330,8 +330,8 @@ static int mpc5xxx_can_probe(struct platform_device *ofdev)
>  		goto exit_free_mscan;
>  	}
>  
> -	dev_info(&ofdev->dev, "MSCAN at 0x%p, irq %d, clock %d Hz\n",
> -		 priv->reg_base, dev->irq, priv->can.clock.freq);
> +	dev_info(&ofdev->dev, "MSCAN at irq %d, clock %d Hz\n",
> +		 dev->irq, priv->can.clock.freq);
>  
>  	return 0;
>  
> diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
> index 1df3c4b54f03..be483b82c314 100644
> --- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
> +++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
> @@ -678,8 +678,8 @@ static int pciefd_can_probe(struct pciefd_board *pciefd)
>  	/* save the object address in the board structure */
>  	pciefd->can[pciefd->can_count] = priv;
>  
> -	dev_info(&pciefd->pci_dev->dev, "%s at reg_base=0x%p irq=%d\n",
> -		 ndev->name, priv->reg_base, ndev->irq);
> +	dev_info(&pciefd->pci_dev->dev, "%s at irq=%d\n",
> +		 ndev->name, pciefd->pci_dev->irq);
>  
>  	return 0;
>  
> diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
> index 4ab91759a5c6..cab01076f60f 100644
> --- a/drivers/net/can/sja1000/ems_pci.c
> +++ b/drivers/net/can/sja1000/ems_pci.c
> @@ -333,8 +333,8 @@ static int ems_pci_add_card(struct pci_dev *pdev,
>  
>  			card->channels++;
>  
> -			dev_info(&pdev->dev, "Channel #%d at 0x%p, irq %d\n",
> -					i + 1, priv->reg_base, dev->irq);
> +			dev_info(&pdev->dev, "Channel #%d, irq %d\n",
> +					i + 1, dev->irq);
>  		} else {
>  			free_sja1000dev(dev);
>  		}
> diff --git a/drivers/net/can/sja1000/ems_pcmcia.c b/drivers/net/can/sja1000/ems_pcmcia.c
> index 4642b6d4aaf7..4f267566edbb 100644
> --- a/drivers/net/can/sja1000/ems_pcmcia.c
> +++ b/drivers/net/can/sja1000/ems_pcmcia.c
> @@ -228,8 +228,8 @@ static int ems_pcmcia_add_card(struct pcmcia_device *pdev, unsigned long base)
>  			card->channels++;
>  
>  			printk(KERN_INFO "%s: registered %s on channel "
> -			       "#%d at 0x%p, irq %d\n", DRV_NAME, dev->name,
> -			       i, priv->reg_base, dev->irq);
> +			       "#%d, irq %d\n", DRV_NAME, dev->name,
> +			       i, dev->irq);
>  		} else
>  			free_sja1000dev(dev);
>  	}
> diff --git a/drivers/net/can/sja1000/f81601.c b/drivers/net/can/sja1000/f81601.c
> index 8f25e95814ef..8e2ba36866fe 100644
> --- a/drivers/net/can/sja1000/f81601.c
> +++ b/drivers/net/can/sja1000/f81601.c
> @@ -184,8 +184,8 @@ static int f81601_pci_probe(struct pci_dev *pdev,
>  		}
>  
>  		card->net_dev[i] = dev;
> -		dev_info(&pdev->dev, "Channel #%d, %s at 0x%p, irq %d\n", i,
> -			 dev->name, priv->reg_base, dev->irq);
> +		dev_info(&pdev->dev, "Channel #%d, %s, irq %d\n", i,
> +			 dev->name, dev->irq);
>  	}
>  
>  	return 0;
> diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
> index 95fe9ee1ce32..b9371579acd2 100644
> --- a/drivers/net/can/sja1000/kvaser_pci.c
> +++ b/drivers/net/can/sja1000/kvaser_pci.c
> @@ -251,8 +251,7 @@ static int kvaser_pci_add_chan(struct pci_dev *pdev, int channel,
>  	priv->irq_flags = IRQF_SHARED;
>  	dev->irq = pdev->irq;
>  
> -	dev_info(&pdev->dev, "reg_base=%p conf_addr=%p irq=%d\n",
> -		 priv->reg_base, board->conf_addr, dev->irq);
> +	dev_info(&pdev->dev, "irq=%d\n", dev->irq);
>  
>  	SET_NETDEV_DEV(dev, &pdev->dev);
>  	dev->dev_id = channel;
> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
> index 84f34020aafb..71e84e2f9773 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -686,9 +686,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  			goto failure_free_dev;
>  		}
>  
> -		dev_info(&pdev->dev,
> -			 "%s at reg_base=0x%p cfg_base=0x%p irq=%d\n",
> -			 dev->name, priv->reg_base, chan->cfg_base, dev->irq);
> +		dev_info(&pdev->dev, "%s at irq=%d\n", dev->name, dev->irq);
>  	}
>  
>  	/* Enable interrupts */
> diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
> index 131a084c3535..743780947c0b 100644
> --- a/drivers/net/can/sja1000/peak_pcmcia.c
> +++ b/drivers/net/can/sja1000/peak_pcmcia.c
> @@ -580,8 +580,8 @@ static int pcan_add_channels(struct pcan_pccard *card)
>  		ccr &= ~PCC_CCR_LED_OFF_CHAN(i);
>  
>  		dev_info(&pdev->dev,
> -			"%s on channel %d at 0x%p irq %d\n",
> -			netdev->name, i, priv->reg_base, pdev->irq);
> +			"%s on channel %d at irq %d\n",
> +			netdev->name, i, pdev->irq);
>  	}
>  
>  	/* write new ccr (change leds state) */
> diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
> index 5de1ebb0c6f0..568e2efed76f 100644
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -704,8 +704,8 @@ static int plx_pci_add_card(struct pci_dev *pdev,
>  
>  			card->channels++;
>  
> -			dev_info(&pdev->dev, "Channel #%d at 0x%p, irq %d "
> -				 "registered as %s\n", i + 1, priv->reg_base,
> +			dev_info(&pdev->dev, "Channel #%d at irq %d "
> +				 "registered as %s\n", i + 1,
>  				 dev->irq, dev->name);
>  		} else {
>  			dev_err(&pdev->dev, "Channel #%d not detected\n",
> diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sja1000/sja1000_isa.c
> index d513fac50718..9fe0f3d72d9f 100644
> --- a/drivers/net/can/sja1000/sja1000_isa.c
> +++ b/drivers/net/can/sja1000/sja1000_isa.c
> @@ -205,8 +205,8 @@ static int sja1000_isa_probe(struct platform_device *pdev)
>  		goto exit_unmap;
>  	}
>  
> -	dev_info(&pdev->dev, "%s device registered (reg_base=0x%p, irq=%d)\n",
> -		 DRV_NAME, priv->reg_base, dev->irq);
> +	dev_info(&pdev->dev, "%s device registered (irq=%d)\n",
> +		 DRV_NAME, dev->irq);
>  	return 0;
>  
>   exit_unmap:
> diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
> index f9ec7bd8dfac..ff99fe711d0b 100644
> --- a/drivers/net/can/sja1000/sja1000_platform.c
> +++ b/drivers/net/can/sja1000/sja1000_platform.c
> @@ -288,8 +288,8 @@ static int sp_probe(struct platform_device *pdev)
>  		goto exit_free;
>  	}
>  
> -	dev_info(&pdev->dev, "%s device registered (reg_base=%p, irq=%d)\n",
> -		 DRV_NAME, priv->reg_base, dev->irq);
> +	dev_info(&pdev->dev, "%s device registered (irq=%d)\n",
> +		 DRV_NAME, dev->irq);
>  	return 0;
>  
>   exit_free:
> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index 25d6d81ab4f4..04f93c2f8eca 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -885,8 +885,8 @@ static int sun4ican_probe(struct platform_device *pdev)
>  	}
>  	devm_can_led_init(dev);
>  
> -	dev_info(&pdev->dev, "device registered (base=%p, irq=%d)\n",
> -		 priv->base, dev->irq);
> +	dev_info(&pdev->dev, "device registered (irq=%d)\n",
> +		 dev->irq);
>  
>  	return 0;
>  
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index ff31b993ab17..fbb0b7b7c16e 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -956,8 +956,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
>  
>  	devm_can_led_init(ndev);
>  
> -	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%u)\n",
> -		 priv->base, (u32)ndev->irq);
> +	dev_info(&pdev->dev, "device registered (irq=%u)\n", (u32)ndev->irq);
>  
>  	return 0;
>  
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 1674b561c9a2..2c5a030c29e7 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -1820,8 +1820,8 @@ static int xcan_probe(struct platform_device *pdev)
>  		priv->write_reg(priv, XCAN_AFR_2_MASK_OFFSET, 0x00000000);
>  	}
>  
> -	netdev_dbg(ndev, "reg_base=0x%p irq=%d clock=%d, tx buffers: actual %d, using %d\n",
> -		   priv->reg_base, ndev->irq, priv->can.clock.freq,
> +	netdev_dbg(ndev, "irq=%d clock=%d, tx buffers: actual %d, using %d\n",
> +		   ndev->irq, priv->can.clock.freq,
>  		   hw_tx_max, priv->tx_max);
>  
>  	return 0;
> -- 
> 2.34.1
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
