Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A3608FDF
	for <lists+linux-can@lfdr.de>; Sat, 22 Oct 2022 23:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJVV6N (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 22 Oct 2022 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJVV6M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Oct 2022 17:58:12 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E61910042B
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 14:58:11 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 10D02240026
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 23:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666475890; bh=1cQqyHFGsfYllj2F/nkqTeZjfs5JzMFVgR5KGYtFDuo=;
        h=Date:Subject:To:Cc:From:From;
        b=NGyJ1x05FD052mHRLL0e2830NwmVyHg+B5xFovKA9/QcW/FiBBOcn7JFTPEVQUclH
         d5aXy6Ju4oex8Y2VeUhZCd1R8y4G52BbkgSmyqDweLMvsnC5Alttm/aHiiGSj9v9LH
         XXvXxg93v9redcSLStEsEtncRsj6xlzn0B1IAtGjRABSsQDaBV30mzIPtdi+925myC
         JQ2cDjaN4VcLzzUyn86TQhyg7ATwSGG56QQeIhFoAlDIh2+qktdOIcNgGc40HJMwIX
         Lyp5siMVQdSiZdCidxuVsxRkbVtmTYDbblYHoinjNzxX/wUL8uCk48Mx3nXqJ4K40p
         MYqbLTX44KX4w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MvwFF2sC4z9rxP;
        Sat, 22 Oct 2022 23:58:09 +0200 (CEST)
Message-ID: <49d7aff9-71b6-432f-4250-d9f4ea345903@posteo.net>
Date:   Sat, 22 Oct 2022 21:57:56 +0000
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v2] can: peak_usb: export PCAN device ID as sysfs
 device attribute
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can@vger.kernel.org
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20220915095410.31854-1-lukas.magel@posteo.net>
 <1ca3bad7-f660-5516-d3a9-adaae07d142a@posteo.net>
 <20220930120649.eqew4xfcjmwplqlh@pengutronix.de>
 <20220930142003.j2scusjbndcuzxa7@pengutronix.de>
Content-Language: en-US
From:   Lukas Magel <lukas.magel@posteo.net>
In-Reply-To: <20220930142003.j2scusjbndcuzxa7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 30.09.22 16:20, Marc Kleine-Budde wrote:
> On 30.09.2022 14:06:49, Marc Kleine-Budde wrote:
>> On 28.09.2022 20:43:19, Lukas Magel wrote:
>>> I was made aware by Stéphane that there has previously been discussion about
>>> registering a sysfs file for reading and writing the device ID [1]. IMHO, I
>>> believe the sysfs file approach would have one important advantage over using
>>> ethtool: udev rule matching.
>>>
>>> I often work with setups that feature several CAN interfaces. In such a setup, I
>>> want to assign persistent interface names via udev in case device probing is not
>>> deterministic or the devices are plugged in to different ports. At the moment,
>>> the PEAK device driver and the underlying USB interface do not export any
>>> practically usable identifier for discriminating between different interfaces of
>>> the same type. The device ID solves this problem since it can be configured per
>>> CAN interface to uniquely identify the interface. If the device ID is exported
>>> as sysfs file, it is directly available for matching in udev rules via the
>>> ATTR{...} key. This would solve the CAN interface identification problem and
>>> allow easy read and write access to the device ID without Windows userspace tools.
>> I'm fine with a RO sysfs attribute. For writing the ethtool interface
>> should be used instead.
I submitted a series of patches to the thread that merge the previous patches
by Stéphane to introduce RW ethtool access and RO access via the sysfs
attribute.
>>
>> Please document the sysfs entry in
>> Documentation/ABI/testing/sysfs-class-net-FOO, with foo according to
>> /sys/class/net/<iface>/FOO,
> I mean with FOO the name of the driver, as in the target of the link
> "/sys/class/net/<iface>/device/driver", which is peak_usb in this case.
>
>> see "Documentation/ABI/testing/sysfs-class-net-grcan" as an example.
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>> index 27b0a72fd885..7af3dd0a1b35 100644
>> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
>> @@ -15,6 +15,8 @@
>>  #include <linux/netdevice.h>
>>  #include <linux/usb.h>
>>  #include <linux/ethtool.h>
>> +#include <linux/device.h>
>> +#include <linux/sysfs.h>
>>  
>>  #include <linux/can.h>
>>  #include <linux/can/dev.h>
>> @@ -53,6 +55,15 @@ static const struct usb_device_id peak_usb_table[] = {
>>  
>>  MODULE_DEVICE_TABLE(usb, peak_usb_table);
>>  
>> +static ssize_t device_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct net_device *netdev = to_net_dev(dev);
>> +	struct peak_usb_device *peak_dev = netdev_priv(netdev);
>> +
>> +	return sysfs_emit(buf, "%08X\n", peak_dev->device_number);
> I just noticed that the driver prints the device ID, but in decimal:
>
> | ➜ (pts/0) frogger@riot:~ (master) journalctl -k|grep peak
> | Sep 30 14:23:24 riot kernel: peak_usb 1-1.4:1.0: PEAK-System PCAN-USB FD v1 fw v3.2.0 (1 channels)
> | Sep 30 14:23:24 riot kernel: peak_usb 1-1.4:1.0 can1: attached to PCAN-USB FD channel 0 (device 1144201745)
> | Sep 30 14:23:24 riot kernel: usbcore: registered new interface driver peak_usb
> | ➜ (pts/0) frogger@riot:~ (master) cat /sys/class/net/can1/device_id 
> | 44332211
>
> While the sysfs attribute is in hex. I have overwritten my original
> device ID with 0x44332211 while testing Stéphane's patch. I'm wondering
> if the serial number printed on the device's housing corresponds to the
> default device ID. Is the printed device ID in hex or dec?
>
> Mine is IPEH-004022-019814:
> - it has leading zeros
> - interpreted as hex, it doesn't fit into 32 bits
> - interpreted as dec and converted into hex: 0xefbb26e6
>   it would fit in 32 bits
>
> If the default device ID corresponds to the printed-on number, do we
> want to see/use this number in the sysfs, too?

I did some checking for the PCAN USB FD device, but I couldn't find a trace
of this serial number. The ser_no attribute in the fw_info struct is zero for
my device. Maybe Stéphane can shed some more light on this number?

>
> regards,
> Marc
>
