Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07B3DA2C6
	for <lists+linux-can@lfdr.de>; Thu, 29 Jul 2021 14:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhG2MCk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 29 Jul 2021 08:02:40 -0400
Received: from smtp02-ext3.udag.de ([62.146.106.33]:37408 "EHLO
        smtp02-ext3.udag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhG2MCk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jul 2021 08:02:40 -0400
Received: from THOMASPC (p54b8f506.dip0.t-ipconnect.de [84.184.245.6])
        by smtp02-ext3.udag.de (Postfix) with ESMTPA id E5CDCE045D;
        Thu, 29 Jul 2021 14:02:35 +0200 (CEST)
From:   "Thomas Wagner" <thomas@the-wagner.de>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>
Cc:     <linux-can@vger.kernel.org>
References: <006401d78461$0b868b60$2293a220$@the-wagner.de> <20210729105539.ppi7rm6uglwbpyov@pengutronix.de>
In-Reply-To: <20210729105539.ppi7rm6uglwbpyov@pengutronix.de>
Subject: RE: Write canfd_frame to can interface
Date:   Thu, 29 Jul 2021 14:02:34 +0200
Message-ID: <00a601d78471$9e6f3ca0$db4db5e0$@the-wagner.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLovzA57bGxcX3nUvQATAnP4bQP2QDyf15pqS/KtvA=
Content-Language: de
Authentication-Results: smtp02-ext3.udag.de;
        auth=pass smtp.auth=thomas@the-wagner.de smtp.mailfrom=thomas@the-wagner.de
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On 2021-07-29 12:55, Marc Kleine-Budde wrote:
> On 29.07.2021 12:03:56, thomas@the-wagner.de wrote:
>> Shouldn't the error only be returned if the
>> canfd_frame I pass has more than 8 bytes when the interface is not in
>> FD-mode?
> 
> A CAN-2.0 frame with 8 bytes is something different than a CAN-FD frame
> with 8 bytes. The kernel uses the length of the frame to decide if it is
> a CAN-2.0 or CAN-FD frame. If your CAN controller has switched CAN-FD
> off, it cannot send CAN-FD frames, thus you get an error.
>
> Does that make sense?

Sure!

I see how a CAN-2.0 frame with 8 bytes differs from a CAN-FD frame with
8-bytes, but when I receive into a canfd_frame I can't differentiate like that
anymore. In userspace an 8B CAN-2.0 frame and an 8B CAN-FD frame look just
the same, no matter the interface running with FD on or off.

... which is wrong as I just noticed. Paying attention to the actual bytes read
by the socket I can see the 16 vs. 72B that make up a can_frame vs. a
canfd_frame respectively. Even when always writing into a canfd_frame.
The same differentiation I must make when sending...

Thanks for the quick reply!

Best regards
Thomas Wagner



