Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4E19D71F
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2020 15:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgDCNEo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Apr 2020 09:04:44 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39136 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390715AbgDCNEo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 09:04:44 -0400
Received: by mail-ed1-f48.google.com with SMTP id a43so9167646edf.6
        for <linux-can@vger.kernel.org>; Fri, 03 Apr 2020 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k9tOdF3HZ7hjhZE7u3W64pJwXcowRT3QiyqJLdS7H/0=;
        b=b732Bhd4NPSK+0NqZb2VtVxCS89vHl8YBjKUmwLfmqvRG/+cjgcSFvDf2Xd0PUSyZa
         4+qqtIQ+MBBsyVokQIOYWZISeEnbnZCti9k4vmCs5ZR2AAwEB7Nm1z3wWoKOpN8l0C9k
         +IC+M26IC9u2yK6XptsSGwM6HjsC0N7qSnOoe8wsBGN36/B18qbWv5QbiDdIDNekF03b
         gPztnDBdMgBgCwDG/kESqrIJLtbPq1O1eimb3LFc4JEP6rf96pg6ZytT46xguQO3FuCT
         PgnfgCXBIpdkzDcxSrznM9LsMFiRcIVqUsvI7SVURGCJh8oGBhPz7xjJqAxuarLBTqYi
         1Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k9tOdF3HZ7hjhZE7u3W64pJwXcowRT3QiyqJLdS7H/0=;
        b=jmEtzgmjdWPIwPfTI7PP76BLVBNqC5toH4zUT/wtMDv6upuEIisT1r8d9PPAkhtVZs
         7OLmGfOP9VhT783JAzatox8LeLEwwFL11P+b7zzNEplYDRmCPEodU90s2WGs/wqhEf56
         Np5w5m4NcBisxW6Qisdl0a5vDk3YJRap6zmXBOqRIec1xEoDkkKARyUYELyw1D0o9Rwv
         rI4DSGIOmZTJ+uXPdWSOufs1EKIOpjtR+XWiSHDdu/Ds5eaWmhCuwcxWx7dXbQjSgqdn
         OnW4LPehpu0SvUV+Dx3rjTox8eqaKrivkKmc8Mrjhu9ErGA5zH8TrT2tkF+StPtQ2oQO
         dijQ==
X-Gm-Message-State: AGi0PuYudbNIIUx/lFkJF0wratH+rw8RN9vDM6OnOnVxPZzz1neILOEd
        EyfffxPRJpuT+2wW7mVfo7PPQkQ5uOjqnpNaiXUTGEZUzx8+XCQo
X-Google-Smtp-Source: APiQypIJqPYcI9afGYgCFRutQBt2i9w8jQqm2lb7X5WRkdl5TfIhz1C0PxgwkQ6eM6lRUG5dpJPXTdXzICoSx/K5nZQ=
X-Received: by 2002:a17:906:1251:: with SMTP id u17mr8004532eja.315.1585919082080;
 Fri, 03 Apr 2020 06:04:42 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Andrejus_Fal=C4=8Dikas?= <andrejus.f@8devices.com>
Date:   Fri, 3 Apr 2020 16:04:28 +0300
Message-ID: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
Subject: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
To:     socketcan@hartkopp.net
Cc:     michal.sojka@cvut.cz, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Mr. Oliver Hartkopp,

I would like to notify you that the case described as the issue is
caused by non-standard use of the device and protocol.

Firstly, the model situation with only a single device on the CAN bus
is invalid and very rarely occurs in real life due to the purpose and
underlying principles of the CAN2.0 protocol. Every CAN message sent
to the bus should be acknowledged by other bus node(s) or it will
increment the error counter and will be retransmitted.

The proper usage of a single device (e. g. for testing or
self-diagnostic purposes) would be to enable loopback mode on when
initialising the device in question, as that will ensure that the
device acknowledges the messages it sends to the bus.

Secondly, usage of termination resistors is a must on a CAN bus, and
according to ISO 11898-2 (CAN High Speed) standard the bus is a linear
bus that must be terminated at each end with 120 Ohm resistors. The
termination resistors are needed to suppress reflections as well as
return the bus to its recessive or idle state.

Moreover, the kernel warnings appear to be caused by the socketCAN
layer using netif_rx() function inside an interrupt, they can be
easily recreated using the obsoleted first generation USB2CAN device
and most likely any other device using socketCAN.

Finally, TX URB aborted(-2) errors are expected in the described
scenario as error code -2 (-ENODEV) simply notifies that the specified
device for the URB to be submitted no longer exists (as is expected
when device is brought down).

Taking into account the findings above we will close this ticket as
the issue was caused by non-standard usage of the device.

Best regards,
Andrejus F.
