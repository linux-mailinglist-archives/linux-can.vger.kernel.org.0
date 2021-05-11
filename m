Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42C37A369
	for <lists+linux-can@lfdr.de>; Tue, 11 May 2021 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhEKJV0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 May 2021 05:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhEKJVS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 May 2021 05:21:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FEC0613ED
        for <linux-can@vger.kernel.org>; Tue, 11 May 2021 02:20:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l2so19361415wrm.9
        for <linux-can@vger.kernel.org>; Tue, 11 May 2021 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+Qb3ETarQ/vtKWwashh1NEh9qw/aCmj6/v/uG5lQ+I=;
        b=B/0XPLk9Y8PBdSncdHyxRp5xL/n3hXiC3spftSmWnAvQ+C+klBwKIQeYXGoGgnlF3o
         s3uWZlLxtipVASfaXi3awUyUlx9xkSgUcgDN1OtfDeI/xa4UZIIvIcj+T62yVHzKES6Z
         yR102Yzox97GjkEeqnNtquAaPJ8p3YMvZLwogaFfQjJNL1OoHNei8oU3XKJfinewiBST
         W3IELCF0jMrYNee6fDi1T61NOxajbM5l+Tf+OfsfdVRDrwddSI/dkMxs/LMrV10bbjTp
         THFY3w1RJxY01aR94rF4BdhCW+vj6Tse0MrPkl1W7TK+elqMu24luYypofqsx37DwPv7
         4B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+Qb3ETarQ/vtKWwashh1NEh9qw/aCmj6/v/uG5lQ+I=;
        b=XCyHxOM+8rec4Sj6IRXVM63mCr5NA3A+TbmWtA/oL75zCTVbRo74X315wPixjabJPn
         sfQrkINE52JAlw+HKW4kl24cvIuQIofvd/qt0mBmZ/lOLqnF1911laQn1HzdXNx34kYc
         rzueTJLaSZ5C7B7hkoPB1wfAWVWWGXE5m0DKAduXyaspJqdneVUcKoDzOrG1s6jyK05a
         +IcJnALCW72kQal7LFXIgivl0mBRINiLMl8PJbHjtycS18xrClCnps5E9+ZFnM+nivfg
         qPYYaZqdSae5PUGhM08Ivm/3z3UPL5sQ00usY6YXizisgPl8LY33myXVwdDogQIJx+tf
         IWKA==
X-Gm-Message-State: AOAM533RSVpWFk5Aelxm1Q9IB8f57QgGWvANzYQbsAPcBOMzxSqW9lII
        Xt2Gpli76TIe8yooh4PBrm5U0C87SbFGTWcW
X-Google-Smtp-Source: ABdhPJySuK6i6iaW2XARFq193i9ZGUyh+Yn19cUYF/9vHHngiJ96TrlgXbi+6CXMlyZv6jRXEnpKQQ==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr35670778wrt.424.1620724809740;
        Tue, 11 May 2021 02:20:09 -0700 (PDT)
Received: from bigthink (92.41.10.184.threembb.co.uk. [92.41.10.184])
        by smtp.gmail.com with ESMTPSA id g11sm27438329wri.59.2021.05.11.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 02:20:09 -0700 (PDT)
Date:   Tue, 11 May 2021 10:20:07 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: CAN: TX frames marked as RX after the sending socket is closed
Message-ID: <20210511092007.t6beiemeufvhu46n@bigthink>
References: <20210510142302.ijbwowv4usoiqkxq@bigthink>
 <20210510153540.52uzcndqyp6yu7ve@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u32vfygc3h2c6apd"
Content-Disposition: inline
In-Reply-To: <20210510153540.52uzcndqyp6yu7ve@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--u32vfygc3h2c6apd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 10, 2021 at 05:35:40PM +0200, Marc Kleine-Budde wrote:
> Can you provide the program to reproduce the issue?

See attached below this email (tx only, rx done with candump).

> Have you increased the CAN interface's txqueuelen?

Yup, qlen is 1000.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com


--u32vfygc3h2c6apd
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="tx_rx_bug.c"

#include <errno.h>
#include <linux/can.h>
#include <net/if.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	const char *if_name = "can0";
	int sockfd;
	struct ifreq req = {};
	struct sockaddr_can sockaddr = {};
	struct can_frame frame = {};
	struct timeval tv;
	char timestr[16];

	sockfd = socket(AF_CAN, SOCK_RAW, CAN_RAW);

	strncpy(req.ifr_name, if_name, IF_NAMESIZE);
	ioctl(sockfd, SIOCGIFINDEX, &req);

	sockaddr.can_family = AF_CAN;
	sockaddr.can_ifindex = req.ifr_ifindex;

	bind(sockfd, (const struct sockaddr *) &sockaddr, sizeof(sockaddr));

	frame.can_dlc = 8;
	memset(frame.data, 0xee, 8);
	for (int i = 0; i < 1000; ++i)
	{
		frame.can_id = (i & 0x7ff);
		send(sockfd, &frame, sizeof(frame), 0);
	}

	close(sockfd);

	gettimeofday(&tv, NULL);
	strftime(timestr, sizeof(timestr), "%H:%M:%S", localtime(&tv.tv_sec));
	printf("Socket closed at %s.%06ld\n", timestr, tv.tv_usec);

	return 0;
}

--u32vfygc3h2c6apd--
