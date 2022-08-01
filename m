Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36670586CEF
	for <lists+linux-can@lfdr.de>; Mon,  1 Aug 2022 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiHAOg0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 1 Aug 2022 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiHAOgZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Aug 2022 10:36:25 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D2033368
        for <linux-can@vger.kernel.org>; Mon,  1 Aug 2022 07:36:23 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ef5380669cso110839907b3.9
        for <linux-can@vger.kernel.org>; Mon, 01 Aug 2022 07:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2j1SEBDr1oDem/7kypqVwzGkjOJpVMx8WGZBSXmmUkk=;
        b=VI8HcCUq5062PC+VzoD3yW6nLq3XCmbSxohTUZrZkXBZuIaAX8++jxGsyNbTV5zsdY
         /kycBJkMKwSTrML0g4siToZhN9VhQ68wI1aEOsxfikuJF5c+/L3fwA/3B/T9Tfr5bjI0
         xEcV2LaoBDvrp2RFP+Pi4yYQl5wb4xrH+9B6Y61BxhSzXtDCk1q41y4hU6vE2TD/8Ov/
         OEtqoPPAOY7XOxV7I5Fj1g7hpTpCv/Dr9YWMsD+KAxFBAov/6RIwNMPBHcn7mPOQyuYY
         G8OWjBaME9pG+2aCqMAj8xr6Bqg19k8n5EliTOF6NTM3bKLP3dcKjc3tu5FhohiZ2H+p
         ON/Q==
X-Gm-Message-State: ACgBeo2GFoyHpj0j4Vh1+oIqdaEvWo6uJ+U3qEkKeCPFJZNWKheorpmL
        SaSE7hEe2f0vGh8EAib+nB312IkWE1N+yeBW62fLMersTbY=
X-Google-Smtp-Source: AA6agR6NzG1pLgNm87/MsnT9z9gZ66uWbOzcWjpwv0JTW79YvJrqCBhM4K1GFdhwdIBVZxlX2H5/ONuZYUHXM7IFYFM=
X-Received: by 2002:a81:11c2:0:b0:31f:5a44:c0b7 with SMTP id
 185-20020a8111c2000000b0031f5a44c0b7mr13674233ywr.518.1659364582452; Mon, 01
 Aug 2022 07:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220801080446.36374-1-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 1 Aug 2022 23:36:10 +0900
Message-ID: <CAMZ6RqJD4w_vpaSABdW26aySviVC9ECN4fsP2F+k3vP8GXg9pw@mail.gmail.com>
Subject: Re: [PATCH v1] can: peak_usb: export PCAN device ID as sysfs device attribute
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Lukas,

Welcome on the linux-can mailing list!

On Mon. 1 août 2022 at 17:13, Lukas Magel <lukas.magel@posteo.net> wrote:
> Peak USB devices support a configurable u8 / u32 device ID. In
> multi-device setups, this device ID can be configured and used to
> identify individual CAN interfaces independent of the order in which
> they are plugged into the system. At the current time, the device ID
> is already queried from the device and stored in the peak_usb_device
> struct.
>
> This patch exports the device ID (called device_number in the struct)
> as a sysfs attribute. The attribute name was chosen to be device_id
> instead of device_number because the latter has been deprecated by Peak
> in their API.
>
> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

For the public record, I did the review in private message.

> ---
> For the moment, the patch only implements read support for the device
> ID. My next goal is to also implement write access. However, this
> will require a more significant modification of the driver since the
> corresponding commands for ID retrieval and configuration are not
> implemented for all device types.
>
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 27b0a72fd885..43df178e9473 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -15,6 +15,8 @@
>  #include <linux/netdevice.h>
>  #include <linux/usb.h>
>  #include <linux/ethtool.h>
> +#include <linux/device.h>
> +#include <linux/sysfs.h>
>
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -53,6 +55,15 @@ static const struct usb_device_id peak_usb_table[] = {
>
>  MODULE_DEVICE_TABLE(usb, peak_usb_table);
>
> +static ssize_t device_id_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct net_device *netdev = to_net_dev(dev);
> +       struct peak_usb_device *peak_dev = netdev_priv(netdev);
> +
> +       return sysfs_emit(buf, "%08X\n", peak_dev->device_number);
> +}
> +static DEVICE_ATTR_RO(device_id);
> +
>  /*
>   * dump memory
>   */
> @@ -887,6 +898,11 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
>         netdev_info(netdev, "attached to %s channel %u (device %u)\n",
>                         peak_usb_adapter->name, ctrl_idx, dev->device_number);
>
> +       err = device_create_file(&netdev->dev, &dev_attr_device_id);
> +       /* Do not error out since device was configured successfully */
> +       if (err)
> +               netdev_warn(netdev, "unable to expose device_id via sysfs %d\n", err);

netdev_warn(netdev, "unable to expose device_id via sysfs %pe\n", ERR_PTR(err));

I forgot this point in my first review. The %pe will print the
mnemotechnic instead of the error number. c.f.:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57f5677e535ba24b8926a7125be2ef8d7f09323c

> +
>         return 0;
>
>  adap_dev_free:
> @@ -923,6 +939,8 @@ static void peak_usb_disconnect(struct usb_interface *intf)
>                 dev->state &= ~PCAN_USB_STATE_CONNECTED;
>                 strlcpy(name, netdev->name, IFNAMSIZ);
>
> +               device_remove_file(&netdev->dev, &dev_attr_device_id);
> +
>                 unregister_netdev(netdev);
>
>                 kfree(dev->cmd_buf);
> --
> 2.37.1
>
