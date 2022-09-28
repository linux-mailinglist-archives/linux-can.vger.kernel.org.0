Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18865EE6B9
	for <lists+linux-can@lfdr.de>; Wed, 28 Sep 2022 22:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiI1Un2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Sep 2022 16:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiI1Un0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Sep 2022 16:43:26 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B838E9A5
        for <linux-can@vger.kernel.org>; Wed, 28 Sep 2022 13:43:22 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A82B2240026
        for <linux-can@vger.kernel.org>; Wed, 28 Sep 2022 22:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1664397800; bh=kFoKGkTXqt2qRYu5fhk9eXU5+GZgDPwlGbN6B3cQUxY=;
        h=Date:Subject:To:Cc:From:From;
        b=lt6W3IK1hvlXDG9gSKEBEJPJNMQNy/qDFWC0r/6HqlKKt0KkiAbO8ob19+WoLa0IM
         qed4uQfLhIK4aPzvPsU1z16ai6jstn9nbO0kV71l1bD2GarWRB+kf+5a+7zgXM0ssX
         d0qXnnJIp4LrXy7Axq08KUmDtpcFg75S/4CsBbdikAaNpCLvdC8PsxhqTisA0wY1bK
         VuXAmKZwIGjTQ+6hsVMTu7skQMQ7zs9lalQ9gmGBmd9nBkUYFAfcfBnVFaumQ3BYL8
         fREG+yAm29yHMEabDkGivTS6jGwv3qtOVV8VQpjXBbJVVVfHvsZyOUxUotol5DjkPm
         Nkw+nUjtcBaWA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Md7k00V3zz6tpn;
        Wed, 28 Sep 2022 22:43:20 +0200 (CEST)
Message-ID: <1ca3bad7-f660-5516-d3a9-adaae07d142a@posteo.net>
Date:   Wed, 28 Sep 2022 20:43:19 +0000
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2] can: peak_usb: export PCAN device ID as sysfs
 device attribute
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can@vger.kernel.org
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20220915095410.31854-1-lukas.magel@posteo.net>
From:   Lukas Magel <lukas.magel@posteo.net>
In-Reply-To: <20220915095410.31854-1-lukas.magel@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

I was made aware by Stéphane that there has previously been discussion about
registering a sysfs file for reading and writing the device ID [1]. IMHO, I
believe the sysfs file approach would have one important advantage over using
ethtool: udev rule matching.

I often work with setups that feature several CAN interfaces. In such a setup, I
want to assign persistent interface names via udev in case device probing is not
deterministic or the devices are plugged in to different ports. At the moment,
the PEAK device driver and the underlying USB interface do not export any
practically usable identifier for discriminating between different interfaces of
the same type. The device ID solves this problem since it can be configured per
CAN interface to uniquely identify the interface. If the device ID is exported
as sysfs file, it is directly available for matching in udev rules via the
ATTR{...} key. This would solve the CAN interface identification problem and
allow easy read and write access to the device ID without Windows userspace tools.

Regards,
Lukas

[1]
https://lore.kernel.org/linux-can/20211117150132.37056-1-s.grosjean@peak-system.com/

On 15.09.22 11:54, Lukas Magel wrote:
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
> CC: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
> V2: Update netdev_warn to output the mnemonic of the error value
>
> Resubmission of the patch. Also added Stéphane as maintainer in CC.
>
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 27b0a72fd885..7af3dd0a1b35 100644
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
> +	struct net_device *netdev = to_net_dev(dev);
> +	struct peak_usb_device *peak_dev = netdev_priv(netdev);
> +
> +	return sysfs_emit(buf, "%08X\n", peak_dev->device_number);
> +}
> +static DEVICE_ATTR_RO(device_id);
> +
>  /*
>   * dump memory
>   */
> @@ -887,6 +898,11 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
>  	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
>  			peak_usb_adapter->name, ctrl_idx, dev->device_number);
>  
> +	err = device_create_file(&netdev->dev, &dev_attr_device_id);
> +	/* Do not error out since device was configured successfully */
> +	if (err)
> +		netdev_warn(netdev, "unable to expose device_id via sysfs: %pe\n", ERR_PTR(err));
> +
>  	return 0;
>  
>  adap_dev_free:
> @@ -923,6 +939,8 @@ static void peak_usb_disconnect(struct usb_interface *intf)
>  		dev->state &= ~PCAN_USB_STATE_CONNECTED;
>  		strlcpy(name, netdev->name, IFNAMSIZ);
>  
> +		device_remove_file(&netdev->dev, &dev_attr_device_id);
> +
>  		unregister_netdev(netdev);
>  
>  		kfree(dev->cmd_buf);
