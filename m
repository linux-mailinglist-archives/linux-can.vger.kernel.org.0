Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0152D0B3E
	for <lists+linux-can@lfdr.de>; Mon,  7 Dec 2020 08:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLGHlv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Dec 2020 02:41:51 -0500
Received: from mailrelay3-2.pub.mailoutpod1-cph3.one.com ([46.30.212.2]:11433
        "EHLO mailrelay3-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgLGHlv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Dec 2020 02:41:51 -0500
X-Greylist: delayed 1043 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 02:41:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:date:message-id:to:
         subject:from:from;
        bh=axLHVmzvPZ5Ok/L5bQnc2+5q1f49EAca7wvWykWpufg=;
        b=kf+B2+sGU5On+sDn+EG0ktRYTPyAe1inrziimyoDIOMW3hm5qAfNrDq40uwau8YCI/JI7MkclJQgs
         uAmi4eIBs+fY0hwon5Q5oaLaPEk+qAWiXfEJntUMW8rxp1CAy6UNaEVBV5OUXZBbJIOXmddiLv+Yts
         xWY8pT/bLEcVxahoW3+jgrL0hPQMHKM5c5KHWrVINE9JoSlj0vsYYINXs7EPDs2WPX0gEivTdA5y37
         3TTxIWm5rEz3rFNBzHU98/6o/BCt6UaQVP1vQWeQAo3lj/VCjFNkY0YaCYGRq/9kYK3d21mHEpzEEF
         nanmi1JE/0d+0jBHdVEBzN7OTw3mezw==
X-HalOne-Cookie: 8dfafe2b9fd3a198dccd5db0e50deafd11f80ee1
X-HalOne-ID: 24532c4b-385d-11eb-8cb5-d0431ea8bb03
Received: from [192.168.0.157] (5.103.118.41.static.fibianet.dk [5.103.118.41])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 24532c4b-385d-11eb-8cb5-d0431ea8bb03;
        Mon, 07 Dec 2020 07:23:45 +0000 (UTC)
From:   =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Subject: mcp251xfd PLL support
To:     linux-can@vger.kernel.org
Message-ID: <c3aae4cb-b5ce-8bba-727b-47231ec742a7@csselectronics.com>
Date:   Mon, 7 Dec 2020 08:23:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

there was some initial patches posted mid October on enabling support 
for the PLL on the mcp251xfd, such that 4 MHz external oscillators were 
supported. Is there anything I can do to help facilitate the merge 
process of these patches (e.g. did I miss a signed-off-by)?

Regards, Magnus.

