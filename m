Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E3483494
	for <lists+linux-can@lfdr.de>; Mon,  3 Jan 2022 17:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiACQIA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 Jan 2022 11:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiACQIA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 Jan 2022 11:08:00 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jan 2022 08:07:59 PST
Received: from mx1.llgoewer.de (mx1.llgoewer.de [IPv6:2a01:4f8:1c1c:7d4a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41D8C061761
        for <linux-can@vger.kernel.org>; Mon,  3 Jan 2022 08:07:59 -0800 (PST)
DKIM-Signature: a=rsa-sha256; bh=HQTpEwrdJU/NfPTuSMV4COpU2TkOpMPJ8UuwMA7+S0E=;
 c=relaxed/relaxed; d=llgoewer.de;
 h=Subject:Subject:Sender:To:To:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@llgoewer.de; s=default; t=1641225174; v=1; x=1641657174;
 b=GPLfrxMAzylffzZHagqluXoQaDrg0O4AjRuIVnoiyamQLrOMBbUWY457pvbXWWN80bTs4q9t
 D3qsJhQSwmnlCHXdwxlQEb4rYh/XCSujwC1TY7mXsheupRKSQJKYuvZxwyRbJBcFGBSDKofzhLV
 wLqtQrzUO/pHv6Co4HBrZsPuBwdcdWCZ444xsTJJitaLDZ/mYWyhlsxN042G1JraUxnuVQ+NXhY
 4Y1ACNMpR7j0fYO6Mtv3L4ZS1ZzdQ6Q5xyJ2VbbUH7LmRTWYcalQKrJrXQhCkMcmCGCjuu84zop
 FjcDvg6we2+691O/zDV9e/5oMLT9qYM042VN4UoCR9MAQ==
Received: by mx1.llgoewer.de (envelope-sender <maik@llgoewer.de>) with
 ESMTPS id 84ff44d4; Mon, 03 Jan 2022 15:52:54 +0000
Date:   Mon, 3 Jan 2022 15:52:54 +0000
From:   Maik =?utf-8?B?QWxsZ8O2d2Vy?= <maik@llgoewer.de>
To:     linux-can@vger.kernel.org
Subject: can-isotp: TX stmin violations
Message-ID: <20220103155254.3htprmrdjur3ke3l@ganymed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello everyone,

I'm currently trying to get a device to do isotp.
Sending and receiving seems to be working perfectly fine.

I'm having the issue that when sending a packet, I can see sporadic
violations of the receivers requested min tx separation time.

The pattern always seems to be the following:


Imagine the receiver requests a min tx separation time of 2 ms in a
control frame.

I then sometimes get consecutive frames with the following scheme
of timestamps on an externally connected logger

..

0.0 ms : CF#1
2.5 ms : CF#2
4.0 ms : CF#3

..


In this example CF#2 is delayed by .5 ms on the wire while CF#3 is sent .5 ms too early
when I look at the delta between CF#2 and CF#3 .

To me it seems that, while the messages are put into some tx-queue at the
correct time, they are not actually put on the wire at that exact time leading to CF#3
being put on the wire too early.


I'm probably completely in the wrong here, but I would greatly appreciate any input.


Regards,
Maik
