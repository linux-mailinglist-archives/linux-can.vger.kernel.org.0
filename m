Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96C6C3640
	for <lists+linux-can@lfdr.de>; Tue, 21 Mar 2023 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCUPwC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 21 Mar 2023 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCUPwB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Mar 2023 11:52:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7C4DE3F;
        Tue, 21 Mar 2023 08:51:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso16347071pjb.3;
        Tue, 21 Mar 2023 08:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G0kLp6Mm7SfLZYLEmhjL4Rp6//HoReW7YGsnetKBwg=;
        b=61Qlsgi5d2/KAOrzbHvk44XXe02MoydZkuHfyv9JRxp3PJxDieLdmlwfGxcixGJKC+
         r7quUYlIANcVsLsxzIEQSKWDih/kjWhSsVBjqtHEqhrgMjMTgHPkj0fLRdUWA0+otBFr
         +V7c101oIj0vCUewFaqT1xOqGhSdud9jobIZQMio1b2Wf9MtljlLGWv/24sXRBWzUNQR
         iC5dP19KU9+/tAOAReVM21ptvSz6pHJQMSw9agpNNzTKDx+qdNIdnRrwAXBYH0cQ9cv2
         HKEm7zjtEborO+okKJfEV4wmBqS8wT4pX+bMGWj5RTPZFFtO4gGdDOdE0YpJRfenMU/E
         NJiw==
X-Gm-Message-State: AO0yUKXzJbe9pLFiXkRgY7lAU78elIuLlYuFRJW+y72kmnvBzIW/YJw+
        7K1Snq2Rj8rwZcrzwBc0xaVVYhZ845ilHtiBwdZzm4WXi6gJvA==
X-Google-Smtp-Source: AK7set9Fb+XEB4iBdN4O6lGKyZj8Xlx6HFxQCO18aBkZFRftL+NbUKwvGd9nFG0nhyQeabbVRvZk235UGv3P/7PBj/Q=
X-Received: by 2002:a17:903:1c4:b0:1a1:b9e6:28ae with SMTP id
 e4-20020a17090301c400b001a1b9e628aemr1206629plh.2.1679413832308; Tue, 21 Mar
 2023 08:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230321081152.26510-1-peter_hong@fintek.com.tw>
In-Reply-To: <20230321081152.26510-1-peter_hong@fintek.com.tw>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 22 Mar 2023 00:50:20 +0900
Message-ID: <CAMZ6RqJWg1H6Yo3nhsa-Kk-WdU=ZH39ecWaE6wiuKRJe1gLMkQ@mail.gmail.com>
Subject: Re: [PATCH V2] can: usb: f81604: add Fintek F81604 support
To:     "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        michal.swiatkowski@linux.intel.com, Steen.Hegelund@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, frank.jungclaus@esd.eu,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, hpeter+linux_kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Peter,

Welcome to the linux-can mailing list.
This is my first review, I will wait for the next version to give a
more thorough look.

On Tue. 21 Mar 2023 at 17:14, Ji-Ze Hong (Peter Hong)
<peter_hong@fintek.com.tw> wrote:

From your email header:
> Content-Type: text/plain; charset="y"

It gives me below error when applying:

  $ wget -o f81604.patch
https://lore.kernel.org/linux-can/20230321081152.26510-1-peter_hong@fintek.com.tw/raw
  $ git am f81604.patch
  error : cannot convert from y to UTF-8
  fatal : could not parse patch

> This patch add support for Fintek USB to 2CAN controller support.
>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
> ---
> Changelog:
> v2:
>         1. coding style refactoring.
>         2. some const number are defined to describe itself.
>         3. fix wrong usage for can_get_echo_skb() in f81604_write_bulk_callback().
>
>  drivers/net/can/usb/Kconfig  |    9 +
>  drivers/net/can/usb/Makefile |    1 +
>  drivers/net/can/usb/f81604.c | 1179 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1189 insertions(+)
>  create mode 100644 drivers/net/can/usb/f81604.c
>
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index 445504ababce..381547939c39 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -147,4 +147,13 @@ config CAN_UCAN
>                   from Theobroma Systems like the A31-µQ7 and the RK3399-Q7
>                   (https://www.theobroma-systems.com/rk3399-q7)
>
> +config CAN_F81604
> +       tristate "Fintek F81604 USB to 2CAN interface"
> +       help
> +         This driver supports the Fintek F81604 USB to 2CAN interface.
> +         The device can support CAN2.0A/B protocol and also support
> +         2 output pins to control external terminator (optional).

Does this mean that the termination resistor can be controlled by the
device? If so, you should populate the relevant termination fields in
struct can_priv (can_priv->termination_const or
can_priv->do_set_termination).

> +         (see also https://www.fintek.com.tw).

Nitpick: add the module name. Something like:

  To compile this driver as a module, choose M here: the module will
be called f81604.

>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> index 1ea16be5743b..9de0305a5cce 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb/
>  obj-$(CONFIG_CAN_MCBA_USB) += mcba_usb.o
>  obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
>  obj-$(CONFIG_CAN_UCAN) += ucan.o
> +obj-$(CONFIG_CAN_F81604) += f81604.o
> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> new file mode 100644
> index 000000000000..969c3f72a2b1
> --- /dev/null
> +++ b/drivers/net/can/usb/f81604.c
> @@ -0,0 +1,1179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Fintek F81604 USB-to-2CAN controller driver.
> + *
> + * Copyright (C) 2023 Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
> + */
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/can/platform/sja1000.h>
> +
> +/* vendor and product id */
> +#define F81604_VENDOR_ID 0x2c42
> +#define F81604_PRODUCT_ID 0x1709
> +#define F81604_MAX_DEV 2
> +#define F81604_MAX_DEVICE_RETRY 100
> +
> +#define F81604_USB_MAX_RETRY 10

I have some trouble understanding the nuance between
F81604_MAX_DEVICE_RETRY and F81604_USB_MAX_RETRY.

When I look below, some functions such as f81604_set_reset_mode()
tries to call  f81604_get_register() F81604_MAX_DEVICE_RETRY times and
f81604_get_register() does F81604_USB_MAX_RETRY attempts. That is to
say that f81604_set_reset_mode() does F81604_MAX_DEVICE_RETRY *
F81604_USB_MAX_RETRY attempts, i.e. one thousand.

I see two issues:

1/ First, the MAX retry is misleading. At first glance, one may think
that the function does either F81604_MAX_DEVICE_RETRY (100) or
F81604_USB_MAX_RETRY (10) when in reality it does 1000 attempts. The
macro should not have MAX in its name if this is not really a maximum.

2/ Why do you need so many attempts in the first place? Is this some
paranoiac safenet? Or does the device really need so many attempts to
operate reliably? If those are needed, I would like to understand the
root cause.

> +#define F81604_USB_TIMEOUT 2000
> +#define F81604_SET_GET_REGISTER 0xA0
> +#define F81604_PORT_OFFSET 0x1000
> +
> +#define F81604_BULK_SIZE 64
> +#define F81604_INT_SIZE 16
> +#define F81604_DATA_SIZE 14
> +#define F81604_MAX_RX_URBS 4
> +
> +#define F81604_CMD_OFFSET 0x00
> +#define F81604_CMD_DATA 0x00
> +
> +#define F81604_DLC_OFFSET 0x01
> +#define F81604_LEN_MASK 0x0f
> +#define F81604_EFF_BIT BIT(7)
> +#define F81604_RTR_BIT BIT(6)
> +
> +#define F81604_ID1_OFFSET 0x02
> +#define F81604_ID2_OFFSET 0x03
> +#define F81604_ID3_OFFSET 0x04
> +#define F81604_ID4_OFFSET 0x05
> +
> +#define F81604_SFF_DATA_OFFSET 0x04
> +#define F81604_EFF_DATA_OFFSET 0x06
> +
> +/* device setting */
> +#define F81604_TX_ONESHOT (0x03 << 3)
> +#define F81604_TX_NORMAL (0x01 << 3)
> +#define F81604_RX_AUTO_RELEASE_BUF (0x01 << 1)
> +#define F81604_INT_WHEN_CHANGE (0x01 << 0)
> +
> +/* SJA1000 registers - manual section 6.4 (Pelican Mode) */
> +#define SJA1000_MOD 0x00
> +#define SJA1000_CMR 0x01
> +#define SJA1000_IR 0x03
> +#define SJA1000_IER 0x04
> +#define SJA1000_ALC 0x0B
> +#define SJA1000_ECC 0x0C
> +#define SJA1000_RXERR 0x0E
> +#define SJA1000_TXERR 0x0F
> +#define SJA1000_ACCC0 0x10
> +#define SJA1000_ACCC1 0x11
> +#define SJA1000_ACCC2 0x12
> +#define SJA1000_ACCC3 0x13
> +#define SJA1000_ACCM0 0x14
> +#define SJA1000_ACCM1 0x15
> +#define SJA1000_ACCM2 0x16
> +#define SJA1000_ACCM3 0x17
> +#define SJA1000_MAX_FILTER_CNT 4
> +
> +/* Common registers - manual section 6.5 */
> +#define SJA1000_BTR0 0x06
> +#define SJA1000_BTR1 0x07
> +#define SJA1000_OCR 0x08
> +#define SJA1000_CDR 0x1F
> +
> +#define SJA1000_FI 0x10
> +#define SJA1000_SFF_BUF 0x13
> +#define SJA1000_EFF_BUF 0x15
> +
> +#define SJA1000_FI_FF 0x80
> +#define SJA1000_FI_RTR 0x40
> +
> +#define SJA1000_ID1 0x11
> +#define SJA1000_ID2 0x12
> +#define SJA1000_ID3 0x13
> +#define SJA1000_ID4 0x14
> +
> +/* mode register */
> +#define MOD_RM 0x01
> +#define MOD_LOM 0x02
> +#define MOD_STM 0x04
> +
> +/* commands */
> +#define CMD_CDO 0x08
> +
> +/* interrupt sources */
> +#define IRQ_BEI 0x80
> +#define IRQ_ALI 0x40
> +#define IRQ_EPI 0x20
> +#define IRQ_DOI 0x08
> +#define IRQ_EI 0x04
> +#define IRQ_TI 0x02
> +#define IRQ_RI 0x01
> +#define IRQ_ALL 0xFF
> +#define IRQ_OFF 0x00
> +
> +/* status register content */
> +#define SR_BS 0x80
> +#define SR_ES 0x40
> +#define SR_TS 0x20
> +#define SR_RS 0x10
> +#define SR_TCS 0x08
> +#define SR_TBS 0x04
> +#define SR_DOS 0x02
> +#define SR_RBS 0x01
> +
> +/* ECC register */
> +#define ECC_SEG 0x1F
> +#define ECC_DIR 0x20
> +#define ECC_BIT 0x00
> +#define ECC_FORM 0x40
> +#define ECC_STUFF 0x80
> +#define ECC_MASK 0xc0
> +
> +/* table of devices that work with this driver */
> +static const struct usb_device_id f81604_table[] = {
> +       { USB_DEVICE(F81604_VENDOR_ID, F81604_PRODUCT_ID) },
> +       {} /* Terminating entry */
> +};
> +
> +MODULE_DEVICE_TABLE(usb, f81604_table);
> +
> +struct f81604_priv {
> +       struct net_device *netdev[F81604_MAX_DEV];
> +};
> +
> +struct f81604_port_priv {
> +       struct can_priv can;
> +       struct net_device *netdev;
> +       struct sk_buff *echo_skb;
> +
> +       /* For synchronize need_clear_alc/need_clear_ecc in worker & interrupt
> +        * callback.
> +        */
> +       spinlock_t lock;
> +       bool need_clear_alc;
> +       bool need_clear_ecc;
> +
> +       struct work_struct handle_clear_reg_work;
> +       struct work_struct handle_clear_overrun_work;
> +
> +       struct usb_device *dev;
> +       struct usb_interface *intf;
> +
> +       struct urb *int_urb;
> +       u8 int_read_buffer[F81604_INT_SIZE];
> +
> +       struct urb *read_urb[F81604_MAX_RX_URBS];
> +       u8 bulk_read_buffer[F81604_MAX_RX_URBS][F81604_BULK_SIZE];
> +
> +       struct urb *write_urb;
> +       u8 bulk_write_buffer[F81604_DATA_SIZE];
> +
> +       u8 ocr;
> +       u8 cdr;
> +};
> +
> +static int f81604_set_register(struct usb_device *dev, u16 reg, u8 data)
> +{
> +       size_t count = F81604_USB_MAX_RETRY;
> +       int status;
              ^^^^^^

Nitpick: return values are often called "ret".

> +       while (count--) {
> +               status = usb_control_msg_send(dev, 0, F81604_SET_GET_REGISTER,
> +                                             USB_TYPE_VENDOR | USB_DIR_OUT, 0,
> +                                             reg, &data, sizeof(u8),
                                                                   ^^

sizeof(data)

> +                                             F81604_USB_TIMEOUT, GFP_KERNEL);
> +               if (!status)
> +                       break;

return 0 here. This way, the if (status) below can be removed.

> +       }
> +
> +       if (status)
> +               dev_err(&dev->dev, "%s: reg: %x data: %x failed: %d\n",
                                                   ^^
> +                       __func__, reg, data, status);

Can you print the mnemotechnic instead of the error value?

               dev_err(&dev->dev, "%s: reg: %x data: %x failed: %pe\n",
                       __func__, reg, data, ERR_PTR(status));

(same comments apply to other error messages).

> +       return status;
> +}
> +
> +static int f81604_get_register(struct usb_device *dev, u16 reg, u8 *data)
> +{
> +       size_t count = F81604_USB_MAX_RETRY;
> +       int status;
> +
> +       while (count--) {
> +               status = usb_control_msg_recv(dev, 0, F81604_SET_GET_REGISTER,
> +                                             USB_TYPE_VENDOR | USB_DIR_IN, 0,
> +                                             reg, data, sizeof(u8),
                                                                  ^^

sizeof(*data)

> +                                             F81604_USB_TIMEOUT, GFP_KERNEL);
> +               if (!status)
> +                       break;
> +       }
> +
> +       if (status < 0)
> +               dev_err(&dev->dev, "%s: reg: %x failed: %d\n", __func__, reg,
> +                       status);
> +
> +       return status;
> +}
> +
> +static int f81604_set_sja1000_register(struct usb_device *dev, u8 port,
> +                                      u16 reg, u8 data)
> +{
> +       int real_reg;
> +
> +       real_reg = reg + F81604_PORT_OFFSET * port + F81604_PORT_OFFSET;
> +       return f81604_set_register(dev, real_reg, data);
> +}
> +
> +static int f81604_get_sja1000_register(struct usb_device *dev, u8 port,
> +                                      u16 reg, u8 *data)
> +{
> +       int real_reg;
> +
> +       real_reg = reg + F81604_PORT_OFFSET * port + F81604_PORT_OFFSET;
> +       return f81604_get_register(dev, real_reg, data);
> +}
> +
> +static int f81604_set_reset_mode(struct net_device *netdev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       int status, i;
> +       u8 tmp;
> +
> +       /* disable interrupts */
> +       status = f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_IER, IRQ_OFF);
> +       if (status)
> +               return status;
> +
> +       for (i = 0; i < F81604_MAX_DEVICE_RETRY; i++) {
> +               status = f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                                    SJA1000_MOD, &tmp);
> +               if (status)
> +                       return status;
> +
> +               /* check reset bit */
> +               if (tmp & MOD_RM) {
> +                       priv->can.state = CAN_STATE_STOPPED;
> +                       return 0;
> +               }
> +
> +               /* reset chip */
> +               status = f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                                    SJA1000_MOD, MOD_RM);
> +               if (status)
> +                       return status;
> +       }
> +
> +       netdev_err(netdev, "setting SJA1000 into reset mode failed!\n");

Nitpick: remove the exclamation mark.

> +       return -EINVAL;
                  ^^^^^^

Why -EINVAL? EINVAL means "Invalid argument". The only argument
provided here is netdev.

> +}
> +
> +static int f81604_set_normal_mode(struct net_device *netdev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       u8 mod_reg = 0x00;
> +       u8 tmp, ier = 0;
> +       int status, i;
> +
> +       for (i = 0; i < F81604_MAX_DEVICE_RETRY; i++) {
> +               status = f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                                    SJA1000_MOD, &tmp);
> +               if (status)
> +                       return status;
> +
> +               /* check reset bit */
> +               if ((tmp & MOD_RM) == 0) {
> +                       priv->can.state = CAN_STATE_ERROR_ACTIVE;
> +                       /* enable interrupts, RI handled by bulk-in */
> +                       if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +                               ier = IRQ_ALL & ~IRQ_RI;
> +                       else
> +                               ier = IRQ_ALL & ~(IRQ_RI | IRQ_BEI);

Nitpick, but I would suggest to simplify as below:

                       ier = IRQ_ALL & ~IRQ_RI;
                       if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
                               ier &= ~IRQ_BEI;

> +
> +                       status = f81604_set_sja1000_register(priv->dev,
> +                                                            netdev->dev_id,
> +                                                            SJA1000_IER, ier);
> +
> +                       return status;
> +               }
> +
> +               /* set chip to normal mode */
> +               if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +                       mod_reg |= MOD_LOM;
> +               if (priv->can.ctrlmode & CAN_CTRLMODE_PRESUME_ACK)
> +                       mod_reg |= MOD_STM;
> +
> +               status = f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                                    SJA1000_MOD, mod_reg);
> +               if (status)
> +                       return status;
> +       }
> +
> +       netdev_err(netdev, "setting SJA1000 into normal mode failed!\n");

f81604_set_register() also prints an error message. Do you really need
two messages? Try to throw only one error message per error.

> +       return -EINVAL;
                  ^^^^^^

Why -EINVAL? EINVAL means "Invalid argument". The only argument
provided here is netdev.

> +}
> +
> +static int f81604_chipset_init(struct net_device *netdev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       int status;
> +       int i;
> +
> +       /* set clock divider and output control register */
> +       status = f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_CDR,
> +                                            priv->cdr | CDR_PELICAN);
> +       if (status)
> +               return status;
> +
> +       /* set acceptance filter (accept all) */
> +       for (i = 0; i < SJA1000_MAX_FILTER_CNT; ++i) {
> +               status = f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                                    SJA1000_ACCC0 + i, 0);
> +               if (status)
> +                       return status;
> +       }
> +
> +       for (i = 0; i < SJA1000_MAX_FILTER_CNT; ++i) {
> +               status = f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                                    SJA1000_ACCM0 + i, 0xFF);
> +               if (status)
> +                       return status;
> +       }
> +
> +       return f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                          SJA1000_OCR,
> +                                          priv->ocr | OCR_MODE_NORMAL);
> +}
> +
> +static void f81604_unregister_urbs(struct net_device *netdev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       int i;
> +
> +       usb_kill_urb(priv->write_urb);
> +
> +       for (i = 0; i < F81604_MAX_RX_URBS; ++i)
> +               usb_kill_urb(priv->read_urb[i]);
> +
> +       usb_kill_urb(priv->int_urb);
> +}
> +
> +static int f81604_register_urbs(struct net_device *netdev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       int status, i;
> +
> +       for (i = 0; i < F81604_MAX_RX_URBS; ++i) {
> +               status = usb_submit_urb(priv->read_urb[i], GFP_KERNEL);
> +               if (status) {
> +                       netdev_warn(netdev, "%s: submit rx urb failed: %d\n",
> +                                   __func__, status);
> +                       return status;
> +               }
> +       }
> +
> +       status = usb_submit_urb(priv->int_urb, GFP_KERNEL);
> +       if (status) {
> +               netdev_warn(netdev, "%s: submit int urb failed: %d\n",
> +                           __func__, status);
> +               return status;
> +       }
> +
> +       return 0;
> +}
> +
> +static int f81604_start(struct net_device *netdev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       int status;
> +       u8 mode;
> +       u8 tmp;
> +
> +       f81604_unregister_urbs(netdev);
> +
> +       mode = F81604_RX_AUTO_RELEASE_BUF | F81604_INT_WHEN_CHANGE;
> +
> +       /* Set TR/AT mode */
> +       if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +               mode |= F81604_TX_ONESHOT;
> +       else
> +               mode |= F81604_TX_NORMAL;
> +
> +       status = f81604_set_sja1000_register(priv->dev, netdev->dev_id, 0x80,
                                              ^^^^

Avoid the use of magic numbers. Replace 0x80 by a #define.

> +                                            mode);
> +       if (status)
> +               return status;
> +
> +       /* set reset mode */
> +       status = f81604_set_reset_mode(netdev);
> +       if (status)
> +               return status;
> +
> +       status = f81604_chipset_init(netdev);
> +       if (status)
> +               return status;
> +
> +       /* Clear error counters and error code capture */
> +       status = f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_TXERR, 0);
> +       if (status)
> +               return status;
> +
> +       status = f81604_set_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_RXERR, 0);
> +       if (status)
> +               return status;
> +
> +       /* Read clear for ECC/ALC/IR register */
> +       status = f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_ECC, &tmp);
> +       if (status)
> +               return status;
> +
> +       status = f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_ALC, &tmp);
> +       if (status)
> +               return status;
> +
> +       status = f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_IR, &tmp);
> +       if (status)
> +               return status;
> +
> +       status = f81604_register_urbs(netdev);
> +       if (status)
> +               return status;
> +
> +       return f81604_set_normal_mode(netdev);
> +}
> +
> +static int f81604_set_bittiming(struct net_device *dev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(dev);
> +       struct can_bittiming *bt = &priv->can.bittiming;
> +       int status = 0;
> +       u8 btr0, btr1;
> +
> +       btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
> +       btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
> +              (((bt->phase_seg2 - 1) & 0x7) << 4);
> +
> +       if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> +               btr1 |= 0x80;

Avoid the use of magic numbers. Replace 0x80 by a #define.

> +
> +       netdev_info(dev, "BTR0=0x%02x BTR1=0x%02x\n", btr0, btr1);

Remove this kernel log. That information should be retrievable through
the "ip" command.

> +       status = f81604_set_sja1000_register(priv->dev, dev->dev_id,
> +                                            SJA1000_BTR0, btr0);
> +       if (status) {
> +               netdev_warn(dev, "%s: Set BTR0 failed: %d\n", __func__,
> +                           status);
> +               return status;
> +       }
> +
> +       status = f81604_set_sja1000_register(priv->dev, dev->dev_id,
> +                                            SJA1000_BTR1, btr1);
> +       if (status) {
> +               netdev_warn(dev, "%s: Set BTR1 failed: %d\n", __func__,
> +                           status);
> +               return status;
> +       }
> +
> +       return 0;
> +}
> +
> +static int f81604_set_mode(struct net_device *netdev, enum can_mode mode)
> +{
> +       int err;
> +
> +       switch (mode) {
> +       case CAN_MODE_START:
> +               err = f81604_start(netdev);
> +               if (!err && netif_queue_stopped(netdev))
> +                       netif_wake_queue(netdev);
> +               break;
> +
> +       default:
> +               err = -EOPNOTSUPP;
> +       }
> +
> +       return err;
> +}
> +
> +static void f81604_process_rx_packet(struct urb *urb)
> +{
> +       struct net_device *netdev = urb->context;
> +       struct net_device_stats *stats;
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
> +       int i, count;
> +       u8 *data;
> +       u8 *ptr;
> +
> +       data = urb->transfer_buffer;
> +       stats = &netdev->stats;
> +
> +       if (urb->actual_length % 14)
> +               netdev_warn(netdev, "actual_length %% 14 != 0 (%d)\n",
> +                           urb->actual_length);
> +       else if (!urb->actual_length)
> +               netdev_warn(netdev, "actual_length = 0 (%d)\n",
> +                           urb->actual_length);
> +
> +       count = urb->actual_length / F81604_DATA_SIZE;
> +
> +       for (i = 0; i < count; ++i) {
> +               ptr = &data[i * F81604_DATA_SIZE];> +
> +               if (ptr[F81604_CMD_OFFSET] != F81604_CMD_DATA)
> +                       continue;
> +
> +               skb = alloc_can_skb(netdev, &cf);
> +               if (!skb) {
> +                       netdev_warn(netdev, "%s: not enough memory", __func__);
> +                       continue;
> +               }
> +
> +               cf->can_dlc = can_cc_dlc2len(ptr[F81604_DLC_OFFSET] & 0xF);

can_dlc is depreciated. Please use cf->len instead.

> +               if (ptr[F81604_DLC_OFFSET] & F81604_EFF_BIT) {
> +                       cf->can_id = (ptr[F81604_ID1_OFFSET] << 21) |
> +                                    (ptr[F81604_ID2_OFFSET] << 13) |
> +                                    (ptr[F81604_ID3_OFFSET] << 5) |
> +                                    (ptr[F81604_ID4_OFFSET] >> 3);
> +                       cf->can_id |= CAN_EFF_FLAG;
> +               } else {
> +                       cf->can_id = (ptr[F81604_ID1_OFFSET] << 3) |
> +                                    (ptr[F81604_ID2_OFFSET] >> 5);
> +               }
> +
> +               if (ptr[F81604_DLC_OFFSET] & F81604_RTR_BIT) {
> +                       cf->can_id |= CAN_RTR_FLAG;
> +               } else if (ptr[F81604_DLC_OFFSET] & F81604_EFF_BIT) {
> +                       memcpy(cf->data, &ptr[F81604_EFF_DATA_OFFSET],
> +                              cf->can_dlc);
> +               } else {
> +                       memcpy(cf->data, &ptr[F81604_SFF_DATA_OFFSET],
> +                              cf->can_dlc);
> +               }
> +
> +               stats->rx_packets++;
> +               stats->rx_bytes += cf->can_dlc;

Do not increment stats->rx_bytes when receiving an RTR frame.

> +               netif_rx(skb);
> +       }
> +}
> +
> +static void f81604_read_bulk_callback(struct urb *urb)
> +{
> +       struct net_device *netdev = urb->context;
> +       u8 *data = urb->transfer_buffer;
> +       int status;
> +
> +       if (!netif_device_present(netdev))
> +               return;
> +
> +       switch (urb->status) {
> +       case 0: /* success */
> +               break;
> +
> +       case -ENOENT:
> +       case -EPIPE:
> +       case -EPROTO:
> +       case -ESHUTDOWN:
> +               netdev_info(netdev, "%s: URB aborted (%d)\n", __func__,
> +                           urb->status);
> +               return;
> +
> +       default:
> +               netdev_info(netdev, "%s: URB aborted (%d)\n", __func__,
> +                           urb->status);
> +               goto resubmit_urb;
> +       }
> +
> +       switch (data[F81604_CMD_OFFSET]) {
> +       case F81604_CMD_DATA:
> +               f81604_process_rx_packet(urb);
> +               break;
> +       default:
> +               netdev_err(netdev, "unknown header: %x, len: %d\n",
> +                          data[F81604_CMD_OFFSET], urb->actual_length);
> +               break;
> +       }
> +
> +resubmit_urb:
> +       status = usb_submit_urb(urb, GFP_ATOMIC);
> +       if (status == -ENODEV) {
> +               netif_device_detach(netdev);
> +       } else if (status) {
> +               netdev_err(netdev, "failed resubmitting read bulk urb: %d\n",
> +                          status);
> +       }
> +}
> +
> +static void f81604_write_bulk_callback(struct urb *urb)
> +{
> +       struct net_device *netdev = urb->context;
> +
> +       if (!netif_device_present(netdev))
> +               return;
> +
> +       if (urb->status)
> +               netdev_info(netdev, "Tx URB error (%d)\n", urb->status);

From the Linux coding style:

  Printing numbers in parentheses (%d) adds no value and should be avoided.

Ref: https://www.kernel.org/doc/html/v4.10/process/coding-style.html#printing-kernel-messages

> +}
> +
> +static void f81604_handle_clear_overrun_work(struct work_struct *work)
> +{
> +       struct f81604_port_priv *priv;
> +       struct net_device *netdev;
> +
> +       priv = container_of(work, struct f81604_port_priv,
> +                           handle_clear_overrun_work);
> +       netdev = priv->netdev;
> +
> +       f81604_set_sja1000_register(priv->dev, netdev->dev_id, SJA1000_CMR,
> +                                   CMD_CDO);
> +}
> +
> +static void f81604_handle_clear_reg_work(struct work_struct *work)
> +{
> +       struct f81604_port_priv *priv;
> +       struct net_device *netdev;
> +       bool clear_ecc, clear_alc;
> +       unsigned long flags;
> +       u8 tmp;
> +
> +       priv = container_of(work, struct f81604_port_priv,
> +                           handle_clear_reg_work);
> +       netdev = priv->netdev;
> +
> +       spin_lock_irqsave(&priv->lock, flags);
> +       clear_alc = priv->need_clear_alc;
> +       clear_ecc = priv->need_clear_ecc;
> +       priv->need_clear_alc = false;
> +       priv->need_clear_ecc = false;
> +       spin_unlock_irqrestore(&priv->lock, flags);
> +
> +       if (clear_alc) {
> +               f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                           SJA1000_ALC, &tmp);
> +       }

When you receive comments, please apply these to the full patch, not
only to where the reviewer put the comment.

Here, the { } brackets are not needed after the if. c.f. Michal's review.

> +
> +       if (clear_ecc) {
> +               f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                           SJA1000_ECC, &tmp);
> +       }
> +}
> +
> +static void f81604_read_int_callback(struct urb *urb)
> +{
> +       struct net_device *netdev = urb->context;
> +       struct net_device_stats *stats;
> +       struct f81604_port_priv *priv;
> +       enum can_state can_state;
> +       enum can_state rx_state;
> +       enum can_state tx_state;
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
> +       unsigned long flags;
> +       u8 rxerr, txerr;
> +       u8 sr, isrc;
> +       u8 alc, ecc;
> +       u8 *data;
> +       int r;
> +
> +       data = urb->transfer_buffer;
> +       priv = netdev_priv(netdev);
> +       can_state = priv->can.state;
> +       stats = &netdev->stats;
> +
> +       if (!netif_device_present(netdev))
> +               return;
> +
> +       switch (urb->status) {
> +       case 0: /* success */
> +               break;
> +
> +       case -ENOENT:
> +       case -EPIPE:
> +       case -EPROTO:
> +       case -ESHUTDOWN:
> +               netdev_info(netdev, "%s: Int URB aborted (%d)\n", __func__,
> +                           urb->status);
> +               return;
> +
> +       default:
> +               netdev_info(netdev, "%s: Int URB aborted (%d)\n", __func__,
> +                           urb->status);
> +               goto resubmit_urb;
> +       }
> +
> +       /* Int EP Read data format: SR/IR/IER/ALC/ECC/EWLR/RXERR/TXERR/VAL
> +        * Note: ALC/ECC will not auto clear by here, must to read clear by
> +        * read register (via handle_clear_reg_work).
> +        */
> +       sr = data[0];
> +       isrc = data[1];
> +       alc = data[3];
> +       ecc = data[4];
> +       rxerr = data[6];
> +       txerr = data[7];

Rather than manipulating an opaque u8 array, please declare a
structure with sr, isrc, alc, ecc, rxerr and txerr as members and cast
the result to it.

> +       /* handle can bus errors */
> +       if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {

The function f81604_read_int_callback() is too long. Can you split it
and add a f81604_handle_can_bus_errors() which will contain below
code?

> +               skb = alloc_can_err_skb(netdev, &cf);
> +               if (!skb) {
> +                       netdev_warn(netdev,
> +                                   "no memory to alloc_can_err_skb\n");
> +                       goto resubmit_urb;
> +               }
> +
> +               cf->data[6] = txerr;
> +               cf->data[7] = rxerr;

Please set the CAN_ERR_CNT flag in cf->can_id to inform that the error
counter is available.

> +               if (isrc & IRQ_DOI) {
> +                       /* data overrun interrupt */
> +                       netdev_dbg(netdev, "data overrun interrupt\n");
> +                       cf->can_id |= CAN_ERR_CRTL;
> +                       cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> +                       stats->rx_over_errors++;
> +                       stats->rx_errors++;
> +
> +                       schedule_work(&priv->handle_clear_overrun_work);
> +               }
> +
> +               if (isrc & IRQ_EI) {
> +                       /* error warning interrupt */
> +                       netdev_dbg(netdev, "error warning interrupt\n");
> +
> +                       if (sr & SR_BS)
> +                               can_state = CAN_STATE_BUS_OFF;
> +                       else if (sr & SR_ES)
> +                               can_state = CAN_STATE_ERROR_WARNING;
> +                       else
> +                               can_state = CAN_STATE_ERROR_ACTIVE;
> +               }
> +
> +               if (isrc & IRQ_BEI) {
> +                       /* bus error interrupt */
> +                       netdev_dbg(netdev, "bus error interrupt\n");
> +
> +                       priv->can.can_stats.bus_error++;
> +                       stats->rx_errors++;
> +
> +                       cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +
> +                       /* set error type */
> +                       switch (ecc & ECC_MASK) {
> +                       case ECC_BIT:
> +                               cf->data[2] |= CAN_ERR_PROT_BIT;
> +                               break;
> +                       case ECC_FORM:
> +                               cf->data[2] |= CAN_ERR_PROT_FORM;
> +                               break;
> +                       case ECC_STUFF:
> +                               cf->data[2] |= CAN_ERR_PROT_STUFF;
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +
> +                       /* set error location */
> +                       cf->data[3] = ecc & ECC_SEG;
> +
> +                       /* Error occurred during transmission? */
> +                       if ((ecc & ECC_DIR) == 0)
> +                               cf->data[2] |= CAN_ERR_PROT_TX;
> +
> +                       spin_lock_irqsave(&priv->lock, flags);
> +                       priv->need_clear_ecc = true;
> +                       spin_unlock_irqrestore(&priv->lock, flags);
> +
> +                       schedule_work(&priv->handle_clear_reg_work);
> +               }
> +
> +               if (isrc & IRQ_EPI) {
> +                       if (can_state == CAN_STATE_ERROR_PASSIVE)
> +                               can_state = CAN_STATE_ERROR_WARNING;
> +                       else
> +                               can_state = CAN_STATE_ERROR_PASSIVE;
> +
> +                       /* error passive interrupt */
> +                       netdev_dbg(netdev, "error passive interrupt: %x\n",
> +                                  can_state);
> +               }
> +
> +               if (isrc & IRQ_ALI) {
> +                       /* arbitration lost interrupt */
> +                       netdev_dbg(netdev, "arbitration lost interrupt\n");
> +
> +                       priv->can.can_stats.arbitration_lost++;
> +                       stats->tx_errors++;
> +                       cf->can_id |= CAN_ERR_LOSTARB;
> +                       cf->data[0] = alc & 0x1f;
> +
> +                       spin_lock_irqsave(&priv->lock, flags);
> +                       priv->need_clear_alc = true;
> +                       spin_unlock_irqrestore(&priv->lock, flags);
> +
> +                       schedule_work(&priv->handle_clear_reg_work);
> +               }
> +
> +               if (can_state != priv->can.state) {
> +                       tx_state = txerr >= rxerr ? can_state : 0;
> +                       rx_state = txerr <= rxerr ? can_state : 0;
> +
> +                       can_change_state(netdev, cf, tx_state, rx_state);
> +
> +                       if (can_state == CAN_STATE_BUS_OFF)
> +                               can_bus_off(netdev);
> +               }
> +
> +               stats->rx_packets++;
> +               stats->rx_bytes += cf->can_dlc;

Remove the two lines above. The "CAN error frame" is an abstraction of
Linux socket CAN. No actual data is transmitted on the wire (except
for an error flag).

> +               netif_rx(skb);
> +       }
> +
> +       /* handle TX */
> +       if ((isrc & IRQ_TI) && can_state != CAN_STATE_BUS_OFF) {

The function f81604_read_int_callback() is too long. Can you split it
and add a f81604_handle_tx() which will contain below code?

> +               /* transmission buffer released */
> +               if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT &&
> +                   !(sr & SR_TCS)) {
> +                       stats->tx_errors++;
> +                       can_free_echo_skb(netdev, 0, NULL);
> +               } else {
> +                       /* transmission complete */
> +                       stats->tx_bytes += can_get_echo_skb(netdev, 0, NULL);
> +                       stats->tx_packets++;
> +               }
> +
> +               netif_wake_queue(netdev);
> +       }
> +
> +resubmit_urb:
> +       r = usb_submit_urb(urb, GFP_ATOMIC);
> +       if (r) {
> +               netdev_err(netdev,
> +                          "%s: failed resubmitting int bulk urb: %d\n",
> +                          __func__, r);
> +
> +               if (r == -ENODEV)
> +                       netif_device_detach(netdev);
> +       }
> +}
> +
> +static netdev_tx_t f81604_start_xmit(struct sk_buff *skb,
> +                                    struct net_device *netdev)
> +{
> +       struct can_frame *cf = (struct can_frame *)skb->data;
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       struct net_device_stats *stats = &netdev->stats;
> +       int status;
> +       u8 *ptr;
> +       u32 id;
> +
> +       if (can_dropped_invalid_skb(netdev, skb))
> +               return NETDEV_TX_OK;
> +
> +       netif_stop_queue(netdev);
> +
> +       ptr = priv->bulk_write_buffer;
> +       memset(ptr, 0, F81604_DATA_SIZE);
> +
> +       ptr[0] = F81604_CMD_DATA;
> +       ptr[1] = min_t(u8, cf->can_dlc & 0xf, 8);
> +
> +       if (cf->can_id & CAN_EFF_FLAG) {
> +               id = (cf->can_id & CAN_ERR_MASK) << 3;
> +               ptr[1] |= F81604_EFF_BIT;
> +               ptr[2] = (id >> 24) & 0xff;
> +               ptr[3] = (id >> 16) & 0xff;
> +               ptr[4] = (id >> 8) & 0xff;
> +               ptr[5] = (id >> 0) & 0xff;
> +               memcpy(&ptr[6], cf->data, ptr[1]);

Rather than manipulating an opaque u8 array, please declare a
structure with explicit names.

> +       } else {
> +               id = (cf->can_id & CAN_ERR_MASK) << 5;
> +               ptr[2] = (id >> 8) & 0xff;
> +               ptr[3] = (id >> 0) & 0xff;
> +               memcpy(&ptr[4], cf->data, ptr[1]);
> +       }
> +
> +       if (cf->can_id & CAN_RTR_FLAG)
> +               ptr[1] |= F81604_RTR_BIT;
> +
> +       can_put_echo_skb(skb, netdev, 0, 0);
> +
> +       status = usb_submit_urb(priv->write_urb, GFP_ATOMIC);
> +       if (status) {
> +               netdev_err(netdev, "%s: failed resubmitting tx bulk urb: %d\n",
> +                          __func__, status);
> +
> +               can_free_echo_skb(netdev, 0, NULL);
> +               stats->tx_dropped++;
> +
> +               if (status == -ENODEV)
> +                       netif_device_detach(netdev);
> +       }
> +
> +       return NETDEV_TX_OK;
> +}
> +
> +static int f81604_get_berr_counter(const struct net_device *netdev,
> +                                  struct can_berr_counter *bec)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       int status;
> +       u8 txerr;
> +       u8 rxerr;
> +
> +       status = f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_TXERR, &txerr);
> +       if (status)
> +               return status;
> +
> +       status = f81604_get_sja1000_register(priv->dev, netdev->dev_id,
> +                                            SJA1000_RXERR, &rxerr);
> +       if (status)
> +               return status;
> +
> +       bec->txerr = txerr;
> +       bec->rxerr = rxerr;
> +
> +       return 0;
> +}
> +
> +static void f81604_remove_urbs(struct net_device *netdev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       int i;
> +
> +       for (i = 0; i < F81604_MAX_RX_URBS; ++i)
> +               usb_free_urb(priv->read_urb[i]);
> +
> +       usb_free_urb(priv->write_urb);
> +       usb_free_urb(priv->int_urb);
> +}
> +
> +static int f81604_prepare_urbs(struct net_device *netdev)
> +{
> +       static const u8 bulk_in_addr[F81604_MAX_DEV] = { 0x82, 0x84 };
> +       static const u8 bulk_out_addr[F81604_MAX_DEV] = { 0x01, 0x03 };
> +       static const u8 int_in_addr[F81604_MAX_DEV] = { 0x81, 0x83 };
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +       int id = netdev->dev_id;
> +       int i;
> +
> +       /* initialize to NULL for error recovery */
> +       for (i = 0; i < F81604_MAX_RX_URBS; ++i)
> +               priv->read_urb[i] = NULL;

priv was allocated with devm_kzalloc() so it should already be zeroed,
right? What is the purpose of this loop?

> +       priv->write_urb = NULL;
> +       priv->int_urb = NULL;
> +
> +       for (i = 0; i < F81604_MAX_RX_URBS; ++i) {
> +               priv->read_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
> +               if (!priv->read_urb[i])
> +                       goto error;
> +
> +               usb_fill_bulk_urb(priv->read_urb[i], priv->dev,
> +                                 usb_rcvbulkpipe(priv->dev, bulk_in_addr[id]),
> +                                 priv->bulk_read_buffer[i], F81604_BULK_SIZE,
> +                                 f81604_read_bulk_callback, netdev);
> +       }
> +
> +       priv->write_urb = usb_alloc_urb(0, GFP_KERNEL);
> +       if (!priv->write_urb)
> +               goto error;
> +
> +       usb_fill_bulk_urb(priv->write_urb, priv->dev,
> +                         usb_sndbulkpipe(priv->dev, bulk_out_addr[id]),
> +                         priv->bulk_write_buffer, F81604_DATA_SIZE,
> +                         f81604_write_bulk_callback, netdev);
> +
> +       priv->int_urb = usb_alloc_urb(0, GFP_KERNEL);
> +       if (!priv->int_urb)
> +               goto error;
> +
> +       usb_fill_int_urb(priv->int_urb, priv->dev,
> +                        usb_rcvintpipe(priv->dev, int_in_addr[id]),
> +                        priv->int_read_buffer, F81604_INT_SIZE,
> +                        f81604_read_int_callback, netdev, 1);
> +
> +       return 0;
> +
> +error:
> +       f81604_remove_urbs(netdev);
> +       return -ENOMEM;
> +}
> +
> +/* Open USB device */
> +static int f81604_open(struct net_device *netdev)
> +{
> +       int err;
> +
> +       err = f81604_prepare_urbs(netdev);
> +       if (err)
> +               return err;
> +
> +       err = open_candev(netdev);
> +       if (err)
> +               goto remove_urbs;
> +
> +       err = f81604_start(netdev);
> +       if (err)
> +               goto start_failed;
> +
> +       netif_start_queue(netdev);
> +       return 0;
> +
> +start_failed:
> +       if (err == -ENODEV)
> +               netif_device_detach(netdev);
> +
> +       close_candev(netdev);
> +
> +remove_urbs:
> +       f81604_remove_urbs(netdev);
> +
> +       return err;
> +}
> +
> +/* Close USB device */
> +static int f81604_close(struct net_device *netdev)
> +{
> +       struct f81604_port_priv *priv = netdev_priv(netdev);
> +
> +       f81604_set_reset_mode(netdev);
> +
> +       netif_stop_queue(netdev);
> +       cancel_work_sync(&priv->handle_clear_overrun_work);
> +       cancel_work_sync(&priv->handle_clear_reg_work);
> +       close_candev(netdev);
> +
> +       f81604_unregister_urbs(netdev);
> +       f81604_remove_urbs(netdev);
> +
> +       return 0;
> +}
> +
> +static const struct net_device_ops f81604_netdev_ops = {
> +       .ndo_open = f81604_open,
> +       .ndo_stop = f81604_close,
> +       .ndo_start_xmit = f81604_start_xmit,
> +       .ndo_change_mtu = can_change_mtu,
> +};
> +
> +static const struct can_bittiming_const f81604_bittiming_const = {
> +       .name = "f81604",
> +       .tseg1_min = 1,
> +       .tseg1_max = 16,
> +       .tseg2_min = 1,
> +       .tseg2_max = 8,
> +       .sjw_max = 4,
> +       .brp_min = 1,
> +       .brp_max = 64,
> +       .brp_inc = 1,
> +};
> +
> +/* Called by the usb core when driver is unloaded or device is removed */
> +static void f81604_disconnect(struct usb_interface *intf)
> +{
> +       struct f81604_priv *priv = usb_get_intfdata(intf);
> +       int i;
> +
> +       for (i = 0; i < F81604_MAX_DEV; ++i) {
> +               if (!priv->netdev[i])
> +                       continue;
> +
> +               unregister_netdev(priv->netdev[i]);
> +               free_candev(priv->netdev[i]);
> +       }
 i> +}
> +
> +static int f81604_probe(struct usb_interface *intf,
> +                       const struct usb_device_id *id)
> +{
> +       struct usb_device *dev = interface_to_usbdev(intf);
> +       struct f81604_port_priv *port_priv;
> +       struct net_device *netdev;
> +       struct f81604_priv *priv;
> +       int i, err;
> +
> +       dev_info(&intf->dev, "Detected Fintek F81604 device.\n");

Remove this. If you want to have an announce, enable
CONFIG_USB_ANNOUNCE_NEW_DEVICES instead.

> +       dev_info(&intf->dev,
> +                "Please download newest driver from Fintek website\n");
> +       dev_info(&intf->dev, "if you want to use customized functions.\n");

Remove this as well. Here, you are unconditionally asking the user to
download the latest firmware without checking the actual version. If
some old version misses some features, then you should dinamically
check the version and adjust the driver behaviour accordingly.

If you want to inform the user of the device firmware version, please
use devlink.

If you want to give more details to the end-user, do not use the
kernel log. Instead, you can create an documentation page under:

  Documentation/networking/device_drivers/can/f81604.rst

> +       priv = devm_kzalloc(&intf->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       usb_set_intfdata(intf, priv);
> +
> +       for (i = 0; i < F81604_MAX_DEV; ++i) {
> +               netdev = alloc_candev(sizeof(*port_priv), 1);
> +               if (!netdev) {
> +                       dev_err(&intf->dev, "Couldn't alloc candev: %d\n", i);
> +                       err = -ENOMEM;
> +
> +                       goto failure_cleanup;
> +               }
> +
> +               port_priv = netdev_priv(netdev);
> +               netdev->dev_id = i;
> +
> +               spin_lock_init(&port_priv->lock);
> +               INIT_WORK(&port_priv->handle_clear_overrun_work,
> +                         f81604_handle_clear_overrun_work);
> +               INIT_WORK(&port_priv->handle_clear_reg_work,
> +                         f81604_handle_clear_reg_work);
> +
> +               port_priv->intf = intf;
> +               port_priv->dev = dev;
> +               port_priv->ocr = OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL;
> +               port_priv->cdr = CDR_CBP;
> +               port_priv->can.state = CAN_STATE_STOPPED;
> +               port_priv->can.clock.freq = 24000000 / 2;

Where does this division by two comes from? Also, use linux/units.h to
increase readability:

               port_priv->can.clock.freq = 12 * MEGA /* Hz */;

> +               port_priv->can.bittiming_const = &f81604_bittiming_const;
> +               port_priv->can.do_set_bittiming = f81604_set_bittiming;
> +               port_priv->can.do_set_mode = f81604_set_mode;
> +               port_priv->can.do_get_berr_counter = f81604_get_berr_counter;
> +               port_priv->can.ctrlmode_supported =
> +                       CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_3_SAMPLES |
> +                       CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_BERR_REPORTING;

Does this device allow to send and receive frames with DLC greater
than 8? c.f. CAN_CTRLMODE_CC_LEN8_DLC.

> +               port_priv->can.ctrlmode_supported |= CAN_CTRLMODE_PRESUME_ACK;
> +               netdev->netdev_ops = &f81604_netdev_ops;

Can you also populate ndev->ethtool_ops with the default timestamp info? c.f.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=409c188c57cd

> +               netdev->flags |= IFF_ECHO;
> +
> +               SET_NETDEV_DEV(netdev, &intf->dev);
> +
> +               err = register_candev(netdev);
> +               if (err) {
> +                       netdev_err(netdev,
> +                                  "couldn't register CAN device: %d\n", err);
> +                       free_candev(netdev);
> +
> +                       goto failure_cleanup;
> +               }
> +
> +               port_priv->netdev = netdev;
> +               priv->netdev[i] = netdev;
> +
> +               dev_info(&intf->dev, "Channel #%d registered as %s\n", i,
> +                        netdev->name);
> +       }
> +
> +       return 0;
> +
> +failure_cleanup:
> +       f81604_disconnect(intf);
> +       return err;
> +}
> +
> +static struct usb_driver f81604_driver = {
> +       .name = "f81604",
> +       .probe = f81604_probe,
> +       .disconnect = f81604_disconnect,
> +       .id_table = f81604_table,
> +};
> +
> +module_usb_driver(f81604_driver);
> +
> +MODULE_AUTHOR("Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>");
> +MODULE_DESCRIPTION("Fintek F81604 USB to 2xCANBUS");
> +MODULE_LICENSE("GPL");

Yours sincerely,
Vincent Mailhol
