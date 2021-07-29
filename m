Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2DF3DA0E1
	for <lists+linux-can@lfdr.de>; Thu, 29 Jul 2021 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhG2KMp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Jul 2021 06:12:45 -0400
Received: from smtp03-ext2.udag.de ([62.146.106.30]:56390 "EHLO
        smtp03-ext2.udag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhG2KMo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jul 2021 06:12:44 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jul 2021 06:12:44 EDT
Received: from THOMASPC (p54b8f506.dip0.t-ipconnect.de [84.184.245.6])
        by smtp03-ext2.udag.de (Postfix) with ESMTPA id A57DCE012E
        for <linux-can@vger.kernel.org>; Thu, 29 Jul 2021 12:03:57 +0200 (CEST)
From:   <thomas@the-wagner.de>
To:     <linux-can@vger.kernel.org>
Subject: Write canfd_frame to can interface
Date:   Thu, 29 Jul 2021 12:03:56 +0200
Message-ID: <006401d78461$0b868b60$2293a220$@the-wagner.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdeEXylJv8eLJZBMQA61Yy5UUnR1Kg==
Content-Language: de
Authentication-Results: smtp03-ext2.udag.de;
        auth=pass smtp.auth=thomas@the-wagner.de smtp.mailfrom=thomas@the-wagner.de
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi there!

I have been working on getting my device compatible with both, CAN and CAN
FD.

For receiving this is working straight forward. My physical interface is CAN
FD capable
and no matter whether I set it up as
  ip link set can0 type can bitrate 500000 fd off
or
  ip link set can0 type can bitrate 500000 fd dbitrate 2000000 off
in code I can always just use the canfd_frame struct and set the
CAN_RAW_FD_FRAMES
option. Doing this I can receive CAN and CAN FD frames in both modes without
having
to fall back to the can_frame struct (as explained in the docs).

For sending I expected a similar behavior. I set the CAN_RAW_FD_FRAMES
option and
always sent using the canfd_frame struct. Sadly, this fails while writing on
the interface
when it is not in FD-mode with an Invalid Argument error. To make this work
without
falling back to the can_frame struct I just do
  write(sock, &canfdf, sizeof(struct can_frame));
where canfdf is a canfd_frame. Not setting CAN_RAW_FD_FRAMES when the
interface
is in CAN mode but sending using the full canfd_frame won't work too.

Is this expected behavior? Shouldn't the error only be returned if the
canfd_frame I
pass has more than 8 bytes when the interface is not in FD-mode?

Regards,
Thomas

