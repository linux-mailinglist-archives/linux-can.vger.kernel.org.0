Return-Path: <linux-can+bounces-2726-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5ABA27437
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 15:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF4A3A2A45
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169A1212D95;
	Tue,  4 Feb 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="stm50rGq"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-65.smtpout.orange.fr [193.252.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DA20C029;
	Tue,  4 Feb 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678738; cv=none; b=uutKAiPN/kq2UolKzYKjQ3v5C3gHvvDMaj0UV6DXmL2cEEGIGTngQ8klFJCiFkjIdAxnlwDACcMmzePfVAooSXJiDmh57wPLzFSvbsFme5DCoQU4sRhlzdhIOobI2YJNuI9KTOfgAshjCHx0KdvkjfLlRNjgeoIfRgmPFKWfNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678738; c=relaxed/simple;
	bh=nvNHt7cwQmDcJEtj+2bHSw5+iiQ9a5ScOXgH8QpHeWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K79jc+kS7uOvEiZ+ILMEAB39mr5V5O6b1d543ZgiPhrG8gA1GnGk8Rg3i9DPMf5BhsnavYft7FntFrpfJG1dtl85z4qNsbe+HZl9H8YHSiz15qYCl7Z/bZfsLQ0fW1aTm/Iv8a98x8i8upzG9IvTGhOcpAQORJzOGZb+6+HZ4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=stm50rGq; arc=none smtp.client-ip=193.252.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id fJc6tfzAathYvfJcBtDPQV; Tue, 04 Feb 2025 15:09:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738678168;
	bh=tUcBiUpcHUfI6arbSS7myC+Gqdvvs9Qfr5JLm5sdhwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=stm50rGq3KIg8byMh5Ql5KS8pcLbdesu1KN2un/jypmXff+cANo+hyFBEHKmC5AwT
	 bDdB7xLc0EmUPWljpSx22kJ4LeH7OERsR9tbcNgHJuep+Gfck6xoxGrx+pbfxJazR7
	 4q6HYgOjHqoKr6m/95A1qKijGrgDolwqfQ8fanCDn0u8qu3hLfxzAEKwTARVJH9KBa
	 OOkMt4oBoNYym7X2A42r8Fzg7/qpYIQ6azTv/9h8AAGdEcscm/rVqF/68AxkFBIxTF
	 c/ugwzgobylldjyVcq5CG9gsOul6R29iI+VGEynRtLnk9mzwn6z+7eMHwdeEYDwbeL
	 Bxs5hING+DHxQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 04 Feb 2025 15:09:28 +0100
X-ME-IP: 124.33.176.97
Message-ID: <b25b21b2-c999-4f21-9ad0-30113b4c655d@wanadoo.fr>
Date: Tue, 4 Feb 2025 23:09:17 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: general protection fault in devlink_info_serial_number_put
To: YAN KANG <kangyan91@outlook.com>, Jiri Pirko <jiri@resnulli.us>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "David S. Miller\"" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SY8P300MB0421E0013C0EBD2AA46BA709A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <SY8P300MB0421E0013C0EBD2AA46BA709A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+To: Jiri Pirko
+To: Jakub Kicinski
+CC: David S. Miller
+CC: Eric Dumazet
+CC: Paolo Abeni
+CC: Simon Horman
+CC: netdev@vger.kernel.org

On 04/02/2025 at 16:44, YAN KANG wrote:
> Dear developers and maintainers,
> 
> I found a new kernel  NULL-Pointer-Dereference bug titiled "general protection fault in devlink_info_serial_number_put" while using modified syzkaller fuzzing tool. I Itested it on the latest Linux upstream version (6.13.0-rc7)related to ETAS ES58X CAN/USB DRIVER, and it was able to be triggered.
> 
> The bug info is:
> 
> kernel revision: v6.13-rc7
> OOPS message: general protection fault in devlink_info_serial_number_put
> reproducer:YES
> 
> After preliminary analysis,  The root casue may be :
> in the function:  es58x_devlink_info_get drivers/net/can/usb/etas_es58x/es58x_devlink.c
> es58x_dev->udev->serial   == NULL ,but no check for it.
> 
>  devlink_info_serial_number_put(req, es58x_dev->udev->serial) triggers NPD .
> 
> Fix suggestion: Check es58x_dev->udev->serial before deference pointer.

Thanks for the report. I acknowledge the issue: the serial number of a
USB device may be NULL and I forget to check this condition.

@netdev and devlink maintainers

I can of course fix this locally, but this that this kind of issue looks
like some nasty pitfall to me. So, I was wondering if it wouldn't be
safer to add the NULL check in the framework instead of in the device.
The netlink is not part of the hot path, so a NULL check should not have
performance impacts.

I am thinking of:

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e015ffbed819..eaee9a1aa91f 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1617,6 +1617,8 @@ static inline int nla_put_sint(struct sk_buff
*skb, int attrtype, s64 value)
 static inline int nla_put_string(struct sk_buff *skb, int attrtype,
                                 const char *str)
 {
+       if (!str)
+               return 0;
        return nla_put(skb, attrtype, strlen(str) + 1, str);
 }

Of course, it is also possible to do the check in
devlink_info_serial_number_put().

What do you think?

> If you fix this issue, please add the following tag to the commit:
> Reported-by: yan kang <kangyan91@outlook.com>
> Reported-by: yue sun <samsun1006219@gmail.com
> 
> I hope it helps.
> Best regards
> yan kang


Yours sincerely,
Vincent Mailhol


